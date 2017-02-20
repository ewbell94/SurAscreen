#Load required packages
library("ChemmineR")
library("ChemmineOB")
library(fmcsR)

#Load sdfset and validate all sdfs
loadsdf<-function(sdffile){
  sdfset<-read.SDFset(sdffile)
  valid<-validSDF(sdfset)
  sdfset<-regenerateCoords(sdfset[valid])
  return(sdfset)
}

#writes a .csv file using built in atom pair fingerprints
writefile<-function(sdffile){
  sdfset<-read.SDFset(sdffile)
  valid<-validSDF(sdfset)
  sdfset<-regenerateCoords(sdfset[valid])
  apset<-sdf2ap(sdfset)
  fpset<-desc2fp(apset)
  write.table(as.character(fpset),"set.csv",sep=",")
}

#writes a .csv file using openbabel fingerprints
writeobfp<-function(sdffile,fptype="FP4"){
  sdfset<-read.SDFset(sdffile)
  valid<-validSDF(sdfset)
  sdfset<-regenerateCoords(sdfset[valid])
  obset<-obmol(sdfset)
  obfp<-fingerprint_OB(obset,fptype)
  if(is.vector(obfp)){obfp=t(as.matrix(obfp))}
  fpset<-new("FPset",fpma=obfp,type=fptype)
  cid(fpset)<-cid(sdfset)
  write.table(as.character(fpset),"set.csv",sep=",")
}

sdfset <- loadsdf("mega.sdf")
apset <- sdf2ap(sdfset)
fpset<-desc2fp(apset)

#The similarity coefficient is defined as c/(a+b+c), which is the proportion of the atom pairs shared among two compounds divided by their union. 
#The variable c is the number of atom pairs common in both compounds, while a and b are the numbers of their unique atom pairs.
fclusters<- cmp.cluster(db=fpset, cutoff = 0.8)
clusters <- cmp.cluster(db=apset, cutoff = 0.6)
cluster.sizestat(fclusters, cluster.result=1)
cluster.visualize(apset, clusters, cluster.result=1, size.cutoff=10) #plots the clusters bigger than 10

#hierarchical clustering, not used because the tree is too big
treeCluster<-function(apset){
  clusters <- cmp.cluster(db=apset, save.distances="distmat.rda", cutoff = 0.6)
  load("distmat.rda")
  hc <- hclust(as.dist(distmat), method="single") 
  hc[["labels"]] <- cid(apset) # Assign correct item labels 
  plot(as.dendrogram(hc), edgePar=list(col=4, lwd=2), horiz=T) 
}

#shows common substructure for each cluster
genClusterFmcs<-function(clusters, sizecutoff=2){
  segment<-NULL
  segset<-NULL
  protoseg<-NULL
  for (i in 1:(nrow(clusters))){
    if(as.integer(clusters[i,2]) < sizecutoff){
      break
    }
    print(paste("Processing cluster ",clusters[i,3]))
    if(i==1 || as.integer(clusters[i-1,3]) == as.integer(clusters[i,3])){
      id<-clusters[i,1]
      if (is.null(segment)){
        segment <- sdfset[id]
      } else {
        test<-fmcs(segment, sdfset[id], au=2, bu=1)
        set<-mcs2sdfset(test)
        segment<-set$target[1]
      }
    } else {
      plotMCS(test)
      good<-TRUE
      if((as.integer(rowSums(atomcountMA(segment))) / as.integer(rowSums(atomcountMA(sdfset[id])))) < .4){
        good<-FALSE
        print(paste(clusters[i-1,3],"was too small of a segment"))
      } 
      if(good){
        if(is.null(protoseg)){
          protoseg<-segment
          segset<-segment
        } else {
          run<-fmcs(protoseg,segment, au=2, bu=1)
          s<-mcs2sdfset(run)
          protoseg<-s$target[1]
          segset<-c(segset,segment)
        }
      }
      segment<-sdfset[clusters[i,1]]
    }
  }
  plot(protoseg)
  sampleFmcs(segset,sampleSize=20)
}

#randomly samples clusters for their substructure and finds a common substructure amongst those substructures
sampleFmcs<-function(sdfset,sampleSize=100,iterations=10){
  for (i in 1:iterations){
    print(paste("Iteration ",i))
    segment<-NULL
    sample<-sample(1:length(sdfset), sampleSize, replace=F)
    for (index in sample){
      mol<-sdfset[index]
      if(is.null(segment)){
        segment<-mol
      } else {
        test<-fmcs(segment, mol, au=2, bu=1)
        set<-mcs2sdfset(test)
        segment<-set$target[1]
      }
    }
    plot(segment)
    plotMCS(test)
  }
}

#testing jarvisPatrick clustering
binCluster<-function(apset, neighbors=6, k=5){
  nnm<-nearestNeighbors(apset,numNbrs=neighbors)
  clust<-byCluster(jarvisPatrick(nnm, k=k, mode="a1a2b"))
  return(clust)
}

#Plot atom frequencies
propma <- atomcountMA(sdfset, addH=FALSE) 
boxplot(propma, col="blue", main="Atom Frequency") 
boxplot(rowSums(propma), main="All Atom Frequency") 

coord <- cluster.visualize(apset, clusters, size.cutoff=10, dimensions=3) 
scatterplot3d(coord)

#write ob fingerprints for each sdfset uploaded
for (i in 1:length(sets)){
  writeobfp(sets[i])
  file.rename(from="set.csv", to=sub(pattern="set",replacement=paste("set",as.character(i-1)),"set.csv"))
}

