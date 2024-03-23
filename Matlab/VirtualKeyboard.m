classdef VirtualKeyboard < handle
    properties
        PanelUI
        Panel;
        KeyButtons = []; % To hold button objects
        CurrentButtonIndex = 1; % Start with the first button
        widthPanel;
        heightPanel;
    end
    
    methods
        function this = VirtualKeyboard(Panel)
            this.PanelUI = Panel;

            size = getpixelposition(this.PanelUI);

            this.widthPanel = size(3);
            this.heightPanel = size(4);
            this.createPanel();
            this.createKeyboard();
            this.highlightButton();
        end
        
        function createPanel(this)
            this.Panel = uipanel(this.PanelUI, ...
                                'Position', [this.widthPanel/2 - this.widthPanel/4, this.heightPanel/20, this.widthPanel/2, this.heightPanel/3]);
        end
        
        function createKeyboard(this)
            numRows = 3;
            numCols = 9; % For 26 letters
            keyWidth = 60;
            keyHeight = 60;
            spacing = 10;
            startX = 60;
            startY = this.heightPanel/3 - 100;
            
            alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
            for i = 1:length(alphabet)
                row = floor((i-1) / numCols);
                col = mod(i-1, numCols);
                xPos = startX + col * (keyWidth + spacing);
                yPos = startY - row * (keyHeight + spacing);
                
                button = uibutton(this.Panel, ...
                                  'Position', [xPos, yPos, keyWidth, keyHeight], ...
                                  'Text', alphabet(i));
                this.KeyButtons = [this.KeyButtons, button];
            end
            row = floor((27-1) / numCols);
            col = mod(27-1, numCols);
            xPos = startX + col * (keyWidth + spacing);
            yPos = startY - row * (keyHeight + spacing);
            
            button = uibutton(this.Panel, ...
                              'Position', [xPos, yPos, keyWidth, keyHeight], ...
                              'Text', 'Save');
            this.KeyButtons = [this.KeyButtons, button];

        end
        
        function highlightButton(this)
            % Reset all button backgrounds
            for i = 1:length(this.KeyButtons)
                this.KeyButtons(i).BackgroundColor = [0.94, 0.94, 0.94]; % Default color
            end
            % Highlight the current button
            this.KeyButtons(this.CurrentButtonIndex).BackgroundColor = [0.8, 0.8, 0.8]; % Highlight color
        end
        
        function BtnLeftPressed(this)
            if this.CurrentButtonIndex > 1
                this.CurrentButtonIndex = this.CurrentButtonIndex - 1;
                this.highlightButton();
            end
        end
        
        function BtnRightPressed(this)
            if this.CurrentButtonIndex < length(this.KeyButtons)
                this.CurrentButtonIndex = this.CurrentButtonIndex + 1;
                this.highlightButton();
            end
        end
        
        function BtnUpPressed(this)
            if this.CurrentButtonIndex > 9 % Assuming 9 buttons per row
                this.CurrentButtonIndex = this.CurrentButtonIndex - 9;
                this.highlightButton();
            end
        end
        
        function BtnDownPressed(this)
            if this.CurrentButtonIndex <= (length(this.KeyButtons) - 9)
                this.CurrentButtonIndex = this.CurrentButtonIndex + 9;
                this.highlightButton();
            end
        end
        
        function key = BtnEnterPressed(this)
            key = this.KeyButtons(this.CurrentButtonIndex).Text;
        end
    end
end