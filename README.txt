Pyonpyon (Coulbourn Sound)
K. Takagaki

This project will perform the following two functions:

[Generate Experiment Protocol]
1. Generate an experiment protocol with a trial list, and accompanying sound stimuli
2. Output this trial list, so that it can be read by Coulbourn "GraphicState"

[Playback Sound During Experiment]
3. coulbourn "GraphicState" will run the behavioral protocol, based on the "trial list" from step 2
4. during the behavioral protocol, "GraphicState" will send a simple TTL trigger to the playback Labview VI
5. The playback VI will play the next sound stimulus on the "trial list"
6. The playback VI will also send a digital event code, for neural recording