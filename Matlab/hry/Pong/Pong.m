classdef Pong < handle
    properties
        hUI
        Ball
        PadlleL
        PadlleR
        fig
        axis
        Height = 700
        Width = 700

        ScorePlayer1
        Acc_Score1 = 0
        Acc_Score2 = 0
        ScorePlayer2

        WelcomeText

        GameStart = 0
    end

    methods
        function this = Pong(hUI)

            this.hUI = hUI;
            this.axis = hUI.Axes;
            set(this.axis, 'XLim', [0,this.Width], 'YLim', [0,this.Height]);

            
            this.Ball = Ball(this);
            this.PadlleL = Padlle(this, 1);
            this.PadlleR = Padlle(this, 0);
            
            this.ScorePlayer1 = text(this.axis, 20, this.Height-20, '0', 'FontSize', 20);
            this.ScorePlayer2 = text(this.axis, this.Width-40, this.Height-20, '0', 'FontSize', 20);
            this.WelcomeText = text(this.axis, this.Width/2-150, this.Height/2+100, 'Press space to start', 'FontSize', 30);
            
            hUI.enableButtonsIRQ([1 1 0 0 1 1]);
            hUI.setTimerFreq(0.01);
            hUI.setMultiplayer();
        end

        function runFrame(this)


            if(this.GameStart)
                this.Ball.update();
                this.edgesCheck();
    
                % if(this.PadlleL.Y+this.PadlleL.Height/20 < this.Ball.Y)
                %     this.PadlleL.moveUp();
                % elseif(this.PadlleL.Y-this.PadlleL.Height/20 > this.Ball.Y)
                %     this.PadlleL.moveDown();
                % end
    
                this.Ball.plotBall();
                this.PadlleL.plotPadlle();
                this.PadlleR.plotPadlle();
            else
            end
           
        end

        function edgesCheck(this)

                if(this.Ball.Y < 0 || this.Ball.Y+this.Ball.Radius > this.Ball.PanelHeight)
                    this.Ball.Vy = -1*this.Ball.Vy;
                end

                if(this.Ball.X+this.Ball.Radius < 0)
                    this.Acc_Score2 = this.Acc_Score2 + 1;
                    set(this.ScorePlayer2, 'String', num2str(this.Acc_Score2));
                    this.hUI.saveScore(this.Acc_Score2);
                    this.Ball.Reset();
                elseif (this.Ball.X > this.Width)
                    this.Acc_Score1 = this.Acc_Score1 + 1;
                    set(this.ScorePlayer1, 'String', num2str(this.Acc_Score1));
                    this.Ball.Reset();
                elseif ((this.Ball.X < this.PadlleL.X+this.PadlleL.Width/2) && (this.Ball.Y+this.Ball.Radius < this.PadlleL.Y+this.PadlleL.Height/2) && (this.Ball.Y > this.PadlleL.Y-this.PadlleL.Height/2))
                    diff = this.Ball.Y - (this.PadlleL.Y - this.PadlleL.Height/2);
                    rad = 45*(pi/180);
                    angle = ((diff - 0)*(rad - -rad))/(this.PadlleL.Height - 0) + -rad;
                    this.Ball.Vx = 3*cos(angle);
                    this.Ball.Vy = 3*sin(angle);
                elseif ((this.Ball.X+this.Ball.Radius > this.PadlleR.X-this.PadlleR.Width/2) && (this.Ball.Y+this.Ball.Radius < this.PadlleR.Y+this.PadlleR.Height/2) && (this.Ball.Y > this.PadlleR.Y-this.PadlleR.Height/2))
                    diff = this.Ball.Y - (this.PadlleR.Y - this.PadlleR.Height/2);
                    rad = 45*(pi/180);
                    angle = ((diff - 0)*(rad - -rad))/(this.PadlleR.Height - 0) + -rad;
                    this.Ball.Vx = -3*cos(angle);
                    this.Ball.Vy = 3*sin(angle);
                end

        end

        function BtnUpPressed(this)
            this.PadlleR.moveUp();
        end

        function BtnDownPressed(this)
            this.PadlleR.moveDown();
        end

        function BtnEnterPressed(this)
            this.GameStart = 1;
            delete(this.WelcomeText);
        end

        function BtnExitPressed(this)
            this.hUI.backToMainMenu();
        end

        function JoyUpPressed(this)
            this.PadlleL.moveUp();
        end

        function JoyDownPressed(this)
            this.PadlleL.moveDown();
        end

    end
end