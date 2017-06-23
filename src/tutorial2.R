#this tutorial includes some basic functions of ggplot2 library
sample <- read.csv("sample.csv")
View(sample)

require(ggplot2)
#plot all winner and error dots
p <- ggplot(sample, aes(winner, error))
p + geom_point()

# color data points and scale the dot size
p <- ggplot(sample, aes(winner, error, colour=factor(victory), size=total))
p + geom_point()

# custome color palette
myPalette <- c("#FF9900", "#0099FF")
p + geom_point() + scale_colour_manual(values=myPalette)

# add label
p <- ggplot(sample, aes(winner, error, colour=factor(victory), size=total, label=player))
p + geom_point() +scale_colour_manual(values=myPalette) + geom_text()

# jitter the label a bit
p + geom_point() +scale_colour_manual(values=myPalette) + 
  geom_text(hjust=-0.2,vjust=1)

# color by match (year), change shape for victory variable
p <- ggplot(sample, aes(winner, error))
p + geom_point(aes(shape=factor(victory), size=total))+
  geom_text(aes(colour=factor(year),label=player), hjust=1.2, vjust=-1)

#split by match, jitter text
p + geom_point(aes(shape=factor(victory), size=total))+
  geom_text(aes(colour=factor(year),label=player), 
            position = position_jitter(width=5,height=1.5) )+facet_grid(~year)

require(ggrepel)
p <- ggplot(sample, aes(winner, error))

#connect each pair with line
task = p + geom_point(aes(shape=factor(victory), size=total,colour=factor(year)))+
  geom_text_repel(aes(colour=factor(year),label=player), nudge_y = -5,nudge_x = 5)+geom_line(aes(colour=factor(year)),size=2)

#set figure background to white & generate charts by column
task=task+ facet_wrap(~year, ncol = 2) +  
  theme(panel.background = element_blank(),plot.background = element_rect(fill = 'white', colour = 'red'))
task

big <- read.csv("big.csv")
#only look at the big 3 players
p <- ggplot(big, aes(factor(year), winner1))
p + geom_boxplot() + facet_grid(~player1)+ geom_jitter(height = 0)

# distribution and density
p + geom_violin() +facet_grid(~player1)+ geom_jitter(height = 0)

# regression line
ggplot(big, aes(x=total1, y=winner1, size=total1, color=player1)) +
  geom_point()+ geom_smooth(method=lm, se=F)

#regression + prediction
ggplot(big, aes(x=total1, y=winner1, size=total1, color=player1)) +
  geom_point()+geom_smooth(method=lm)


