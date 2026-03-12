* 
cluster completelinkage zcalories zsodium zalcohol zcost, measure(L2squared)

* Create dendrogram to visualize the levels for making groups
* For large datasets, dendrogram is impractical — use stopping rules instead
cluster dendrogram _clus_2
* For big datasets: Statistics >> Multivariate Analysis >> Clustering >> Post-Clustering >> Stopping Rules >> Calinski/H method

* After clustering, the output is a hierarchical ID column showing group assignments; tabulate to inspect summary statistics


cluster generate hierarg_2groups = groups(2), name(_clus_2) ties(error)
cluster generate hierarg_3groups= groups(3), name(_clus_2) ties(error )
cluster generate hierarg_4groups = groups(4), name(_clus_2) ties(error )

mean Calories Sodium Alcohol Cost, over(hierarg2)


* 
cluster kmeans zcalories zsodium zalcohol zcost, k(4) measure(L2squared) start(krandom) generate(kmeangroup) keepcenters

* Comparing hierarchical and K-means clustering results
tabulate hierarg_4groups kmeangroup

