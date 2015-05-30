# script accepts parameters and creates an ics text file for calendar imports.



function(startDate, subject) {
        
        line1 <- 'BEGIN:VCALENDAR'
        line2 <- 'VERSION:2.0'
        line3 <- 'BEGIN:VEVENT'
        line4 <- paste('SUMMARY:', subject, sep='')
        line5 <- 'END:VEVENT'
        line6 <- 'END:VCALENDAR'
        
        f <- file("test.ics")
        writeLines(c(line1, line2, line3, line4, line5, line6), f)
        close(f)
}
        
        
        f <- file("test.ics")
        writeLines(c('line 1','line 2 hello world'), f)
        close(f)
        