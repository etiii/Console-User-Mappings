# Console-User-Mappings
powershell scripts to to grab console user drive and printer mappings

These are a couple of short powershell scripts I used to grab mappings for the user logged into the console session on the computer.  We used this with Dell Kace custom inventory rules to report back to the Kace device.  They would be executed in the system user context.  We would grab the console user session and sid using WMI.  Then grab the data from User branch in the registry.
