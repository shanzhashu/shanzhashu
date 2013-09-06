object FormMain: TFormMain
  Left = 60
  Top = 117
  Width = 979
  Height = 563
  Caption = #19978#28023#38750#25293#19981#21487#20799#31461#25668#24433#31649#29702#31995#32479
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  Menu = mmMain
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    971
    517)
  PixelsPerInch = 96
  TextHeight = 12
  object dbgrdOrders: TDBGrid
    Left = 32
    Top = 32
    Width = 897
    Height = 409
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dsOrders
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = GB2312_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = #23435#20307
    TitleFont.Style = []
    OnDblClick = dbgrdOrdersDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'BabyName'
        Title.Caption = #23453#23453#22995#21517
        Width = 54
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Age'
        Title.Caption = #24180#40836
        Width = 32
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ContactNum'
        Title.Caption = #32852#31995#26041#24335
        Width = 72
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'OrderDate'
        Title.Caption = #19979#35746#26085#26399
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Price'
        Title.Caption = #22871#39184#37329#39069
        Width = 54
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Payment'
        Title.Caption = #24050#20184#37329#39069
        Width = 54
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'StatusText'
        Title.Caption = #35746#21333#29366#24577
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ShotDate'
        Title.Caption = #25293#29031#26085#26399
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CustomerTakenDate'
        Title.Caption = #21462#20214#26085#26399
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DesignNameText'
        Title.Caption = #35774#35745#26041
        Width = 84
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DesignSendDate'
        Title.Caption = #35774#35745#21457#20986
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DesignReceiveDate'
        Title.Caption = #35774#35745#23436#31295
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FactoryNameText'
        Title.Caption = #21046#20316#26041
        Width = 84
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SendToFactoryDate'
        Title.Caption = #21046#20316#21457#20986
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RecvFromFactoryDate'
        Title.Caption = #21046#20316#23436#25104
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PicContent'
        Title.Caption = #22871#39184#20869#23481
        Visible = True
      end>
  end
  object statMain: TStatusBar
    Left = 0
    Top = 498
    Width = 971
    Height = 19
    Panels = <>
  end
  object actlstMain: TActionList
    Left = 56
    Top = 48
    object actNewOrder: TAction
      Category = 'New'
      Caption = '&O. '#26032#24314#39044#32422#23458#25143#35746#21333'...'
      OnExecute = actNewOrderExecute
    end
    object actNewShot: TAction
      Category = 'New'
      Caption = '&S. '#26032#24314#25293#25668#23458#25143'...'
      OnExecute = actNewShotExecute
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
    object actQueryAfterSentToFactory: TAction
      Category = 'Query'
      Caption = #24050#21457#21046#20316
      OnExecute = actQueryAfterSentToFactoryExecute
    end
    object actQueryAfterSentToDesign: TAction
      Category = 'Query'
      Caption = #24050#21457#35774#35745
      OnExecute = actQueryAfterSentToDesignExecute
    end
    object actQueryAfterRecvFromDesign: TAction
      Category = 'Query'
      Caption = #35774#35745#23436#31295
      OnExecute = actQueryAfterRecvFromDesignExecute
    end
    object actQueryOrdered: TAction
      Category = 'Query'
      Caption = #26410#25293#25668#30340#39044#32422#23458#25143
      OnExecute = actQueryOrderedExecute
    end
    object actQueryShot: TAction
      Category = 'Query'
      Caption = #24050#25293#25668#26410#36873#29255#23458#25143
      OnExecute = actQueryShotExecute
    end
    object actQueryAfterRecvFromFactory: TAction
      Category = 'Query'
      Caption = #21046#20316#23436#25104
      OnExecute = actQueryAfterRecvFromFactoryExecute
    end
    object actBackupDatabase: TAction
      Caption = '&B. '#22791#20221#25968#25454#24211'...'
    end
    object actQueryAll: TAction
      Category = 'Query'
      Caption = '&A. '#25152#26377#35746#21333
      OnExecute = actQueryAllExecute
    end
    object actManageSuite: TAction
      Category = 'Manage'
      Caption = '&S. '#31649#29702#22871#39184'...'
      OnExecute = actManageSuiteExecute
    end
    object actQueryNotTaken: TAction
      Category = 'Query'
      Caption = #21046#20316#23436#25104#26410#21462#20214#23458#25143
      OnExecute = actQueryNotTakenExecute
    end
    object actQueryTaken: TAction
      Category = 'Query'
      Caption = #24050#21462#20214#23458#25143
      OnExecute = actQueryTakenExecute
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
      object N17: TMenuItem
        Action = actQueryNotTaken
      end
      object N18: TMenuItem
        Action = actQueryTaken
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object N9: TMenuItem
        Action = actQueryAfterSentToDesign
      end
      object N10: TMenuItem
        Action = actQueryAfterRecvFromDesign
      end
      object N11: TMenuItem
        Action = actQueryAfterSentToFactory
      end
      object N12: TMenuItem
        Action = actQueryAfterRecvFromFactory
      end
      object N15: TMenuItem
        Caption = '-'
      end
      object A1: TMenuItem
        Action = actQueryAll
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
      object N16: TMenuItem
        Action = actManageSuite
      end
      object N13: TMenuItem
        Caption = '-'
      end
      object N14: TMenuItem
        Action = actBackupDatabase
      end
    end
  end
  object dsOrders: TDataSource
    DataSet = DataModuleMain.dsOrderForms
    Left = 160
    Top = 120
  end
end
