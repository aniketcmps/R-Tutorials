x <- c(0,-1,-3,1,3)
y <- c(0,2,6,-2,-6)
plot(x,y)

plot(x, y, main="Plot", sub="subtitle",
     xlab="X-axis", ylab="y-axis",
     xlim=c(-6, 6), ylim=c(-6, 6)) 

require(stats) # for rnorm
plot(1:4, rnorm(4), axes = FALSE)
axis(1, 1:4, LETTERS[1:4])
axis(2)
box() #- to make it look "as usual"

plot(1:7, rnorm(7), main = "axis() examples",
     type = "s", xaxt = "n", frame = FALSE, col = "red")
axis(1, 1:7, LETTERS[1:7], col.axis = "blue")

# unusual options:
axis(4, col = "violet", col.axis = "dark violet", lwd = 2)
axis(3, col = "gold", lty = 2, lwd = 0.5)

# one way to have a custom x axis
plot(1:10, xaxt = "n")
axis(1, xaxp = c(2, 9, 7))