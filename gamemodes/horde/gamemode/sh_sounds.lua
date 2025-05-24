-- sound.Add({name = "", channel = CHAN_"", volume = 1.0, level = 75, pitch = 100, sound = ""})
-- https://developer.valvesoftware.com/wiki/Soundscripts

sound.Add(
    {
        name = "Horde_Bullet_Feedback", 
        volume = 0.5, 
        level = 75, 
        pitch = {95,110}, 
        sound = {")feedback/bullet_impact_01.wav",")feedback/bullet_impact_02.wav",")feedback/bullet_impact_03.wav",")feedback/bullet_impact_04.wav",")feedback/bullet_impact_05.wav",")feedback/bullet_impact_06.wav",")feedback/bullet_impact_07.wav",")feedback/bullet_impact_08.wav"}
    }
)
sound.Add(
    {
        name = "Horde_Bullet_Headshot_Feedback", 
        volume = 1.0, 
        level = 75, 
        pitch = {95,110}, 
        sound = {")feedback/headshot_noarmor_01.wav",")feedback/headshot_noarmor_02.wav",")feedback/headshot_noarmor_03.wav",")feedback/headshot_noarmor_04.wav",")feedback/headshot_noarmor_05.wav"}
    }
)
sound.Add(
    {
        name = "Horde_Headshot_Feedback", 
        volume = 1.0, 
        level = 75, 
        pitch = 100, 
        sound = {")feedback/headshot1.wav",")feedback/headshot2.wav"}
    }
)
