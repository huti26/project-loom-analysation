# General
Both ```/Time/``` and ```/Heap/``` have a subfolder named ```/Scripts/```. Inside that folder there are Python scripts, which create the plots. The plots are saved in ```/Plots/```.   


# /Time/ 
ApacheBench Results are saved as ```.txt``` files in ```/Data/```. Each run is in a subfolder of ```/Data/```. A folder like ```/Data/500-10000-t/``` reads as follows: 500 reps, 10.000 total requests, normal threads were used. All Data is run with a concurrency of 100.

Run ```data_extractor.py``` to extract the run times for all measurement series. The data will be saved in ```/CSV/all.csv```.

# /Heap/
Heap records are exported from ```JProfiler``` and are already ```.csv``` files. The values they contain are in bytes. Therefore they are saved in ```/CSV/Bytes/```.  

Use ```bytes_to_megabytes.py``` in order to convert those values to megabytes. They will be stored in ```/CSV/Megabytes/```.


