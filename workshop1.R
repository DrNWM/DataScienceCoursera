a <- 1
b <- c(1,5,6,7)
c <- a+b  # vectorised the object
d <- kamarul # will throw an error
d <- "kamarul" # this is the asterisk

text_data <- c(
  "The quick brown fox",
  "jumps over 1 lazy dog.",
  "Phone: 555-1234",
  "Phone:555-1234",
  "bbbPhone:555-1234",
  "Email: test@example.com",
  "another.email@test.net",
  "No match here.",
  "123-456-7890",
  "foxes run, cat run"
)
?grepl
grepl("\\d",text_data) # we are expecting no 2,3,7
sum(grepl("\\d",text_data)) # lazy to count. 
grepl(pattern = "fox", x = text_data) # so "FOXES" in no. 8 is included
grepl(pattern = "\\bfox\\b", x = text_data)

email_pattern <- "\\w+@+\\w+.+\\w"
grep(email_pattern,text_data) # general pattern 


email_pattern <- "\\w+@\\w+\\.\\w+"
grep(pattern = email_pattern, x = text_data, value=TRUE) # #value is set at FALSE. 

args(mean)
?mean

grep(pattern = "\\bfox\\b", x = text_data, value = TRUE)
?gsub

gsub(pattern = "\\d", replacement = "", x = text_data)

sub(pattern = "\\d", replacement = "0", x = text_data)

gsub(pattern = "^(Phone: |Email: )", replacement = "", x = text_data)

gsub("\\d", replacement="", x=text_data
     
gsub(pattern = "\\d", replacement = "", x = text_data)


gsub(pattern = "(Phone:`\\s?`|Email:`\\s?`)", replacement = "", x = text_data)
gsub(pattern = "(Phone: |Email: )", replacement = "", x = text_data)

gsub(pattern = "(Phone: |Email: )", replacement = "", x = text_data)

grepl("\\d{7}",text_data)

phone_pattern <- "\\d{3}-\\d{4}"

matches <- regexpr(pattern = phone_pattern, text = text_data)
print(matches)


NRIC <-  c("881223-14-6678", "881223146678", "88122314-6678")

cleaned_NRIC <- gsub("-","", NRIC)
cleaned_NRIC

sub("(\\d{6})-(\\d{2})-(\\d{4})","\\1-\\2-\\3",cleaned_NRIC)


# Challenge dataset
sales_data <- c(
  "Order 101: $45.99",
  "Order 102: $120.50",
  "Order 103: $19.00",
  "Order 104: $0.99",
  "REFUND: -$20.00",
  "Invalid Entry"
)


sales_data
pattern <- "\\$"
grepl(pattern,sales_data)


install.packages("shiny")
