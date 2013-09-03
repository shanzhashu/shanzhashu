object FormMain: TFormMain
  Left = 192
  Top = 107
  Width = 979
  Height = 563
  Caption = #19978#28023#38750#25293#19981#21487#20799#31461#25668#24433#31649#29702#31995#32479
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = mmMain
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object actlstMain: TActionList
    Left = 48
    Top = 48
    object actNewOrder: TAction
      Caption = '&O. '#26032#24314#39044#32422#23458#25143'...'
      OnExecute = actNewOrderExecute
    end
    object actNewShot: TAction
      Caption = '&S. '#26032#24314#25293#25668#23458#25143'...'
    end
    object actManageDesign: TAction
      Caption = '&D. '#31649#29702#35774#35745#26041'...'
      OnExecute = actManageDesignExecute
    end
    object actManageFactory: TAction
      Caption = '&F. '#31649#29702#21046#20316#26041'...'
      OnExecute = actManageFactoryExecute
    end
    object actExit: TAction
      Caption = '&X. '#36864#20986
      OnExecute = actExitExecute
    end
  end
  object mmMain: TMainMenu
    Left = 96
    Top = 48
    object N1: TMenuItem
      Caption = '&N. '#26032#24314
      object N4: TMenuItem
        Action = actNewOrder
      end
      object N5: TMenuItem
        Action = actNewShot
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object X1: TMenuItem
        Action = actExit
      end
    end
    object Q1: TMenuItem
      Caption = '&Q. '#26597#35810
    end
    object M1: TMenuItem
      Caption = '&M. '#31649#29702
      object N2: TMenuItem
        Action = actManageDesign
      end
      object N3: TMenuItem
        Action = actManageFactory
      end
    end
  end
end
