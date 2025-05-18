-- sound.Add({name = "", channel = CHAN_STATIC, volume = 1.0, level = 75, pitch = 100, sound = ""})
--
-- Here are some useful tips for other devs:
-- Symbols: # makes sounds connected to music volume, ^ makes stereo left channel audio play close and pans the right channel audio play far, ) makes stereo audio directional.
-- Channels: CHAN_STATIC allows for the audio to play over each other thought not recommended as it floods the audio engine. Rest are common channels: CHAN_BODY, CHAN_ITEM, CHAN_VOICE, and CHAN_WEAPON.
-- Levels: 75 is the most common level, 140 is for gunshots or sounds you want to play far out, 0 is everywhere so it's good for music or UI elements.
--
-- - func_brush

sound.Add(
    {
        name = "Horde_Bullet_Feedback", 
        channel = CHAN_BODY, 
        volume = 1.0, 
        level = 75, 
        pitch = {95,110}, 
        sound = {"feedback/bullet_impact_01.wav","feedback/bullet_impact_02.wav""feedback/bullet_impact_03.wav""feedback/bullet_impact_04.wav""feedback/bullet_impact_05.wav""feedback/bullet_impact_06.wav""feedback/bullet_impact_07.wav""feedback/bullet_impact_08.wav"}
    }
)
sound.Add(
    {
        name = "Horde_Headshot_Feedback", 
        channel = CHAN_BODY, 
        volume = 1.0, 
        level = 75, 
        pitch = {95,110}, 
        sound = {"feedback/headshot_noarmor_01.wav","feedback/headshot_noarmor_02.wav","feedback/headshot_noarmor_03.wav","feedback/headshot_noarmor_04.wav","feedback/headshot_noarmor_05.wav"}
    }
)