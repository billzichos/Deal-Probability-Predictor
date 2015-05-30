# script accepts parameters and creates an ics text file for calendar imports.

function(startDate, subject, description) {
        
        f <- file("test.ics")
        
        writeLines(c(line01 <- 'BEGIN:VCALENDAR',
                     line02 <- 'VERSION:2.0',
                     line03 <- 'PRODID:R',
                     line04 <- 'BEGIN:VEVENT',
                     line05 <- 'UID:bill.zichos',
                     line06 <- 'DTSTAMP:20150530T170000Z',
                     line07 <- 'ORGANIZER;CN=Bill Zichos:MAILTO:billzichos@hotmail.com',
                     line08 <- 'DTSTART:20150530T170000Z',
                     line09 <- 'DTEND:20150530T180000Z',
                     line10 <- paste('SUMMARY:', subject, sep=''),
                     line11 <- paste('DESCRIPTION:', description, sep=''),
                     line12 <- 'END:VEVENT',
                     line13 <- 'END:VCALENDAR'
                     ), f)
                
        close(f)
}