#this tutorial includes some basic functions of igraph library
require(igraph)
ga.data <- read.csv('ga_edgelist.csv', header=TRUE)
g <- graph.data.frame(ga.data, directed=FALSE)
plot(g)

#explore communities, cluster library
#plot a modularized graph & a clustered graph
wc <- walktrap.community(g)
plot(wc, g)
modularity(wc)
membership(wc)

#clusters
clustered_g <- clusters(g, mode="strong")$membership
plot(g, vertex.color=clustered_g)

#greedy
fc<-fastgreedy.community(g)
plot(fc, g)
modularity(fc)
membership(fc)

#degree centrality
centralization.degree(g)
centralization.degree(g)$centralization

#betweenness
centralization.betweenness (g)

btw <- betweenness(g)
btw.score <- round(btw) + 1
btw.colors <- heat.colors(max(btw.score))
V(g)$color <- btw.colors[ btw.score ]
plot(g ,vertex.label=V(g)$label)

btw.colors <- rev(heat.colors(max(btw.score)))
V(g)$size<-log(btw.score)*5
V(g)$label<-NA
plot(g)
