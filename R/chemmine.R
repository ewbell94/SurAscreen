#Written by Eric Bell
#1/17/17
#
#chemmine.R declares functions that interface with ChemmineR, ChemmineOB, and fmcsR

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

sdfset <- loadsdf("mega.sdf")
apset <- sdf2ap(sdfset)

#The similarity coefficient is defined as c/(a+b+c), which is the proportion of the atom pairs shared among two compounds divided by their union. 
#The variable c is the number of atom pairs common in both compounds, while a and b are the numbers of their unique atom pairs.
clusters <- cmp.cluster(db=apset, save.distances="distmat.rda", cutoff =0.7)
cluster.sizestat(clusters,cluster.result=1) #shows size of clusters
cluster.visualize(apset, clusters, cluster.result=1, size.cutoff=5) #plots the clusters bigger than 10

#hierarchical clustering, not used because the tree is too big for visualization
treeCluster<-function(apset){
  clusters <- cmp.cluster(db=apset, save.distances="distmat.rda", cutoff = 0.6)
  load("distmat.rda")
  hc <- hclust(as.dist(distmat), method="single") 
  hc[["labels"]] <- cid(apset) # Assign correct item labels 
  plot(as.dendrogram(hc), edgePar=list(col=4, lwd=2), horiz=T) 
}

#used for determination of the optimal similarity cutoff
clusterTest<-function(vals,apset){
  for (val in vals){
    clusters <- cmp.cluster(db=apset, cutoff = val)
    genClusterFmcs(clusters)
  }
}

#shows common substructure for each cluster and generates a common sub-substructure of the substructures
genClusterFmcs<-function(clusters, sizecutoff=5){
  segment<-NULL
  segset<-NULL
  protoseg<-NULL
  goodcount<-0 #this count is used for cutoff determination
  for (i in 1:(nrow(clusters))){
    #stops when the clusters get too small
    if(as.integer(clusters[i,2]) < sizecutoff){
      break
    }
    print(paste("Processing cluster ",clusters[i,3])) #this is just so I know its running
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
      #plotMCS(test)
      good<-TRUE
      #rejects if the substructure is too small
      if((as.integer(rowSums(atomcountMA(segment))) / as.integer(rowSums(atomcountMA(sdfset[id])))) < .4){
        good<-FALSE
        print(paste(clusters[i-1,3],"was too small of a segment"))
      } 
      if(good){
        #test<-fmcs(segment, sdfset[id], au=2, bu=1)
        #plotMCS(test)
        goodcount<- goodcount+1
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
  #sampleFmcs(segset,sampleSize=20)
  print(goodcount)
}

#randomly samples clusters for their substructure and finds a common substructure amongst those substructures
#the data from this function was not analyzed in this report, but the implementation works
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
boxplot(propma, main="",xlab="Atom",ylab="Atom Count per Molecule")
boxplot(rowSums(propma), main="",xlab="Atom Count per Molecule",horizontal=TRUE) 

#Analogue for the single-linkage clustering using k-means clustering, not used in the scope of this report
kCluster<-function(distmat,k=20){
  fit<-kmeans(as.dist(distmat),k)
  #clusplot(distmat,fit$cluster,color=TRUE,labels=4,lines=0)
  return(fit)
}

#Analogue for clusterFmcs using K means clustering, not used within the scope of this report
genKClusterFmcs<-function(fit, sdfset, k, sizecutoff=2){
  segment<-NULL
  segset<-NULL
  protoseg<-NULL
  list<-list()
  for (j in 1:k){
    part<-list()
    for (i in 1:length(fit$cluster)){
      clus<-fit$cluster[i]
      if (clus==j){
        part<-append(part,list(i))
      }
    }
    list<-append(list,list(part))
  }
  for (i in 1:k){
    print(paste("Processing cluster ",as.character(i)))
    for (j in 1:length(list[[i]])){
      if (is.null(segment)){
        segment<-sdfset[as.integer(list[[i]][j])]
      } else{
        test<-fmcs(segment, sdfset[as.integer(list[[i]][j])], au=2, bu=1)
        set<-mcs2sdfset(test)
        segment<-set$target[1]
      }
    }
    plotMCS(test)
    if(is.null(segset)){
    #  protoseg<-segment
      segset<-segment
    } else{
    #  run<-fmcs(protoseg,segment, au=2, bu=1)
    #  s<-mcs2sdfset(run)
    #  protoseg<-s$target[1]
      segset<-c(segset,segment)
    }
    segment<-NULL
  }
  #plot(protoseg)
  return(segset)
}

