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
    Left = 56
    Top = 48
    object actNewOrder: TAction
      Category = 'New'
      Caption = '&O. '#26032#24314#39044#32422#23458#25143'...'
      OnExecute = actNewOrderExecute
    end
    object actNewShot: TAction
      Category = 'New'
      Caption = '&S. '#26032#24314#25293#25668#23458#25143'...'
    end
    object actManageDesign: TAction
      Category = 'Manage'
      Caption = '&D. '#31649#29702#35774#35745#26041'...'
      OnExecute = actManageDesignExecute
    end
    object actManageFactory: TAction
      Category = 'Manage'
      Caption = '&F. '#31649#29702#21046#20316#26041'...'
      OnExecute = actManageFactoryExecute
    end
    object actExit: TAction
      Caption = '&X. '#36864#20986
      OnExecute = actExitExecute
    end
    object actQuerySentToFactory: TAction
      Category = 'Query'
      Caption = #24050#21457#21046#20316
    end
    object actQuerySentToDesign: TAction
      Category = 'Query'
      Caption = #24050#21457#35774#35745
    end
    object actQueryRecvFromDesign: TAction
      Category = 'Query'
      Caption = #35774#35745#23436#31295
    end
    object actQueryOrdered: TAction
      Category = 'Query'
      Caption = #26410#25293#25668#30340#39044#32422#23458#25143
    end
    object actQueryShot: TAction
      Category = 'Query'
      Caption = #24050#25293#25668#26410#36873#29255#23458#25143
    end
    object actQueryRecvFromFactory: TAction
      Caption = #21046#20316#23436#25104
    end
  end
  object mmMain: TMainMenu
    Left = 104
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
      object N7: TMenuItem
        Action = actQueryOrdered
      end
      object N8: TMenuItem
        Action = actQueryShot
      end
      object N9: TMenuItem
        Action = actQuerySentToDesign
      end
      object N10: TMenuItem
        Action = actQueryRecvFromDesign
      end
      object N11: TMenuItem
        Action = actQuerySentToFactory
      end
      object N12: TMenuItem
        Action = actQueryRecvFromFactory
      end
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
