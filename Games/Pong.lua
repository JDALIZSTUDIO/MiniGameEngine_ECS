return {
    new = function()
        local game = require('Games/CoreGame').new("Pong")

        function game:Load_Scenes()
            --Scene_Manager:Add("intro",      'Scenes/Scene_Intro')
            --Scene_Manager:Add("title",      'Scenes/Scene_Title')
            --Scene_Manager:Add("menu",       'Scenes/Scene_Menu')
            Scene_Manager:Add("gameplay",   'Scenes/Scene_Gameplay')
            Scene_Manager:Add("gameOver",   'Scenes/Scene_Game_Over')
            Scene_Manager:Add("highScores", 'Scenes/Scene_HighScores')
        end

        return game
    end
  }