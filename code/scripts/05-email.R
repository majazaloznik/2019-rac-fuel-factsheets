# =========================================================================== #
# 5. Email script                                                             #
# =========================================================================== #

subject <-  paste0("RACF Fuel factsheet", Sys.Date() -1)

recipients <- paste(#"anneka.lawson@racfoundation.org;",
                    "ivo.wengraf@racfoundation.org;" #,
                    #"nick@javelin.eu;",
                    #"marc@javelin.eu;",
                    #"philip.gomm@racfoundation.org"
                    )
recipients2 <- c(#"anneka.lawson@racfoundation.org",
                    "ivo.wengraf@racfoundation.org"#,
                    #"nick@javelin.eu", 
                    #"marc@javelin.eu",
                    #"philip.gomm@racfoundation.org"
                    )

msg.body <- "Dear Nick and Marc,

Please find attached the data for this week's fuel factsheet.

Please note that this email has been sent via an automated script.
"
on.exit(writeLines("Email script completed.\n\nWhole factsheet script completed. "))

# --------------------------------------------------------------------------- #
# email using outlook ------------------------------------------------------- #
# --------------------------------------------------------------------------- #

if (work.computer  & .Platform$OS.type != "unix") {
  OutApp=COMCreate("Outlook.Application")
  OutMail=OutApp$CreateItem(0)
  OutMail[["To"]]  = recipients
  OutMail[["Subject"]] = subject
  OutMail[["Body"]]  = msg.body
  OutMail[["Attachments"]]$Add(attachments)
  OutMail$Send()
}

# --------------------------------------------------------------------------- #
# email if not using  office pc --------------------------------------------- #
# --------------------------------------------------------------------------- #

if (!work.computer) {
  email <- send.mail(from = sender.email,
                     to = recipients2,
                     subject= subject,
                     body = msg.body,
                     smtp = list(host.name = "smtp.office365.com", port = 587, 
                                 user.name = sender.email, 
                                 passwd = password,
                                 tls = TRUE),
                     authenticate = TRUE,
                     send = TRUE,
                     attach.files = attachments)
}

