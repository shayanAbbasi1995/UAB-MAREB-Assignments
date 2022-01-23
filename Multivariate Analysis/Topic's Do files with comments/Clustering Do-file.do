* 
cluster completelinkage zcalories zsodium zalcohol zcost, measure(L2squared)

* creating dendrogram to visuals the levels on making groups
* If we have large dataset, using dendrogram is absurd
cluster dendrogram _clus_2
* for big datasets: go to statistics >> multivariate analysis >> clustering >> postClustering >> Cluster analysis stopping rules >> Calinski/H method

* After clusteering the output is hierarcialID columns showing the groups >> we can tabulate the column to see it's summary statistics


cluster generate hierarg_2groups = groups(2), name(_clus_2) ties(error)
cluster generate hierarg_3groups= groups(3), name(_clus_2) ties(error )
cluster generate hierarg_4groups = groups(4), name(_clus_2) ties(error )

mean Calories Sodium Alcohol Cost, over(hierarg2)


* 
cluster kmeans zcalories zsodium zalcohol zcost, k(4) measure(L2squared) start(krandom) generate(kmeangroup) keepcenters

* Commparing 2 methods Hierarical and Kmeans
tabulate hierarg_4groups kmeangroup

