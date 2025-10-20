set.seed(10)
x <- rnorm(100)
f <- rep(0:1,each = 50)
y <- x+f-f* x + rnorm(100,sd=0.5)
f <- factor (f,labels=c("Group 1","Group 2"))
xyplot (y~x | f, layout =c(2,1))


# Example 1: Custom panel function with median line
xyplot(y ~ x | f, panel = function(x, y, ...) {
         panel.xyplot(x, y, ...)  # Default scatter plot
         panel.abline(h = median(y), lty = 2, col = "red")  # Add median line
       }
)

# Example 2: Custom panel function with regression line
xyplot(y ~ x | f, panel = function(x, y, ...) {
         panel.xyplot(x, y, ...)  # Default scatter plot
         panel.lmline(x, y, col = "blue")  # Add regression line
})