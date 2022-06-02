# PNGFS - PNG File Storage Converter Tool
![PNGFS in action!](https://i.imgur.com/GG6GWFQ.png)
## What is this project?
This is a simple tool that converts actual files (such as .ZIP, .TXT, .Torrent  etc) into graphical data on a PNG image!
This data can later be extracted back out into it's original file anytime later, or split into multiple PNG images and stitched together. Since PNG images feature compression, sometimes it can be smaller than the original file too!


**Ok... but why make this project?**
I loved using forums during the 2000s, but forums seem to be dying in favour of social media and other chat clients. But one of the features I missed on forum sites was being able to *upload attachments*.
![Attachments RIP](https://i.imgur.com/HwSRx33.png)
Reddit and Twitter don't have this feature, Facebook usually deletes files or just straight up blocks them. And Discord has a 8mb size limit.
But with this PNGFS (PNG File Storage) format, files can now be shared on any site that supports PNG images.
This also allows sites never intended for file storage such as Imgur for theretically unlimted cloud storage! (Although I'm not sure if this breaks their TOS) ![Laughing](https://i.imgur.com/TPYDJsW.gif)

## How do you convert a file into a PNGFS?
Simply click the **Convert** menu -> **Convert File to PNGFS...**
![Convert to PNGFS](https://i.imgur.com/EhF2gXC.png)

These boxes simply change what the output image size (as in width and height, not filesize) will be.
![Canvas Sizes](https://i.imgur.com/H3vlenP.png)

These options allow you to change the background canvas, there are 3 modes total:
![Background Canvas](https://i.imgur.com/YMhXGbb.png)
|![Background Canvas - Dithering](https://i.imgur.com/rHL10CR.png)  |![Background Canvas - No Dithering](https://i.imgur.com/MLDwCzW.png)|![No Background Canvas](https://i.imgur.com/CMSZsQR.png)|
|--|--|--|
|Background Canvas - Dithering Enabled|Background Canvas - Dithering Disabled|No Background Canvas|

These are the main boxes where the magic happens. The input file path will be the source file you're wanting to package (Lets say a word document or something).
The output file path is where the PNGFS image(s) will be saved.
As for the Internal Filename box, that will be the default filename and extension that will be used when somebody or yourself extracts the PNGFS file later.
![Input Output](https://i.imgur.com/cztJkXC.png)

## How do you convert a PNGFS image back to a file?
Click on the **Convert** menu -> **Convert PNGFS to File...**
![Convert PNGFS to File](https://i.imgur.com/7uzqvXj.png)

Then select any PNGFS file on your computer.
If you're choosing a multipage PNGFS, it doesn't matter which one you click on, it doesn't matter what they're named or what other mixed PNGFS files are in the same directory.
As long as all the pages for the file you are trying to export are in the same directory, it should be fine.![Select PNGFS](https://i.imgur.com/Kg1wOiN.png)

With any luck, you'll see a default filename from the PNGFS itself. Click save and enjoy your file!
![Select Output](https://i.imgur.com/gQmdY4o.png)

## Misc Stuff
**How does the PNGFS format work?**
It's actually pretty simple. Each pixel in a PNG image can contain 4 bytes of information (Red, Green, Blue, Alpha). The PNGFS format here simply reads the pixels in that from the top left to the right which is then saved into a binary file (or vice versa).

Of course there needs to be some kind of metadata too *(filesize? filename? checksum?)* So 32 bytes (or 8 pixels) are used as a header.
For dithered images it works the same but every 2nd pixel is skipped. Revealing a somewhat noisy image that still contains extractable data.
If you want exact details on how the PNGFS header works, checkout the **PNGFS Header Format.txt** file. Or extract this PNGFS image:
![header.txt](https://i.imgur.com/HOnAvL3.png)

**How much data can be stored in a PNGFS image?**
For a rough calculation you can do **Width x Height x 4** and that's how many bytes can fit.
If this is exceeded, PNGFS Converter Tool will ask to split it into multiple images.
If you are using the dithered background image setting, then it's about **Width x Height x 2** instead, as every 2nd pixel is skipped.


**Future plans:**

 - I would love to add a Windows Explorer context menu, and quick
   convert command line options.      
 - I would also like to make a Chrome
   extension where right clicking a PNGFS on a webpage will have a
   "Download" option.  
 - Maybe make an installer for the Releases tab?
 - Drag and drop functionality



**Changelog:**

	0.2
		* Cleaned up Source Code for Github release here.
		* Added a couple new recognised file types
		* The resize to uneven width popup no longer shows if Enable Dithering is unchecked.
		* Header is rejected if its page count is <= 0.
		* Added more error checks when converting files back to binary form.
		* Fixed a bug where if something failed to extract/convert, the old error message would always come back even if you convert a different file.
		* CRC16 Errors are now more detailed (Shows exactly which page and what checksum was expected)
		* Converting back to a binary no longer makes a empty file before the confirmation box.
	0.1.1
		* Fixed the centering of some of the "Canvas Width/Height" text labels.
		* The tool now tells you how many pages will be exported.
    0.1
	    * Fixed a bug where extracting files would be corrupted if the internal filename was less than 12 characters.
	    * Added a few more file extensions in the name list.
    0.1 Alpha:
		* Initial Patreon release / testing
If you like what I'm doing and want to support me and the PNGFS project, you can become a Patreon member! ![O Boi](https://i.imgur.com/2lumvvr.gif)
[![Become a Patron](https://i.imgur.com/kpQ5XUP.png)](https://www.patreon.com/Kippykip)