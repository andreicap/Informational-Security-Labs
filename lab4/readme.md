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
  * Cameras used: `Canon PowerShot SX230` HS & `Cannon PowerShot A550`
  * Photos of Alex Railean were taken at a beach, in WA, USA (near Pacific Ocean), according to GPS data from the photos metadata.
  * In the documents was found the `info.railean.net` link, with a little of digging, more info about Alex Railean could be foun [here](http://railean.net/index.php/2007/02/11/about_alex_railean).
  * 