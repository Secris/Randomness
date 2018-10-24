@echo off
:: Needed a way to get a computer from domain A to access a share on domain B
::
:: Found here
:: https://serverfault.com/questions/268938/how-to-force-windows-to-prompt-for-credentials-while-accessing-share

net use \\servername\share /delete
net use \\servername\sharename /u:domain\username
