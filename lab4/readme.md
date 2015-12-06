# Informational Security - Laboratory Work #4

### Objectives
-----
  * Understand the basics of digital forensics.
  * Apply your skills by analyzing the obtained evidence.
  * Extract as much useful information * as you can.
  * Connect the dots and build a portrait of the suspect.
  
### Task
-----
Given an image of a partition of a flash memory card, analyze the data and gather as much intel as you can.
Document your findings and understand who owned the flash card and whether they're involved in any illegal activities.   

##### File extraction
A image in bin format was given and its SHA1 checksum:  
File: `evidence.bin`. **SHA1**: `3c2094f2d62cb530ac642591c34ad86ab15fe88b`

To get information divided files from the image I used `Photorec` program as recommended.  
A total of 92 files was recovered with different types: text files, images (.jpgs & .pngs), audio files, archives(rar, pkcs), documents(pdf, doc, xls).

##### Conclusions after first diving into files
There is a lot of information, but a big part is apparently useless for the task. Audiobooks, source codes, books, students lists. All these files leads to the conclusion: **This info belongs to Alex Railean, a FAF (TUM) teacher of Network Programming and Informational Security**.

##### Metadata analysis
Analyzing the metadata from the files I found out:
  * Cameras used: `Canon PowerShot SX230` HS & `Cannon PowerShot A550`.
  * Photos of Alex Railean were taken at a beach, in WA, USA (near Pacific Ocean), according to GPS data from the photos metadata.
  * In the documents was found the `info.railean.net` link, with a little of digging, more info about Alex Railean could be found [here](http://railean.net/index.php/2007/02/11/about_alex_railean).
  * Alex is a MS Windows user, as a lot of files have specifics of Windows ones. (bat files, screenshots of apps).
  * Alex is employed at `DEKART`.
##### Questions
*Has the suspect ever visited the Kingdom of Jvompihia?  
Were they hiding anything on that flash disk on purpose?*  
I found this questions bound.
As it turns, the owner of the information *may* have visited Jvompihia. Using a `hex viewer` I got a string that says that:  
```
...6egÜh¶Üh»m¸!ÊﬂÒeèÇ∞H&‰ÿ7`¯Yes, I have been to Jvompihia back in 2011 and I met the king himself. Code-word: zubrique. Haha, only serious! Yes, you got it! Yeehaw! «œ ...
```