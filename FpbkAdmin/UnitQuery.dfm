object FormQuery: TFormQuery
  Left = 211
  Top = 132
  BorderStyle = bsDialog
  Caption = #26681#25454#26085#26399#26597#35810
  ClientHeight = 169
  ClientWidth = 427
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object grpQuery: TGroupBox
    Left = 16
    Top = 16
    Width = 393
    Height = 97
    Caption = #26085#26399
    TabOrder = 0
    object lblStart: TLabel
      Left = 16
      Top = 28
      Width = 60
      Height = 12
      Caption = #36215#22987#26085#26399#65306
    end
    object lblEnd: TLabel
      Left = 208
      Top = 28
      Width = 60
      Height = 12
      Caption = #32467#26463#26085#26399#65306
    end
    object dtpStart: TDateTimePicker
      Left = 80
      Top = 24
      Width = 89
      Height = 20
      Date = 41529.946978252320000000
      Time = 41529.946978252320000000
      TabOrder = 0
    end
    object dtpEnd: TDateTimePicker
      Left = 280
      Top = 24
      Width = 89
      Height = 20
      Date = 41529.946978252320000000
      Time = 41529.946978252320000000
      TabOrder = 1
    end
    object tlbDays: TToolBar
      Left = 18
      Top = 57
      Width = 335
      Height = 29
      Align = alNone
      BorderWidth = 1
      ButtonHeight = 18
      ButtonWidth = 48
      Caption = 'tlbDays'
      EdgeBorders = []
      Flat = True
      List = True
      ParentShowHint = False
      ShowCaptions = True
      ShowHint = True
      TabOrder = 2
      object btnThisMonth: TToolButton
        Left = 0
        Top = 0
        Caption = #26412#26376#20869
        ImageIndex = 0
      end
      object btnPrevMonth: TToolButton
        Left = 48
        Top = 0
        Caption = #19978#26376#20869
        ImageIndex = 1
      end
      object btnOneMonth: TToolButton
        Left = 96
        Top = 0
        Caption = #19968#26376#20869
        ImageIndex = 2
      end
      object btnThreeMonth: TToolButton
        Left = 144
        Top = 0
        Caption = #19977#26376#20869
        ImageIndex = 3
      end
      object btnSixMonth: TToolButton
        Left = 192
        Top = 0
        Caption = #20845#26376#20869
        ImageIndex = 4
      end
      object btnOneYear: TToolButton
        Left = 240
        Top = 0
        Caption = #19968#24180#20869
        ImageIndex = 5
      end
    end
  end
  object btnOK: TButton
    Left = 246
    Top = 128
    Width = 75
    Height = 25
    Caption = #30830#23450
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TButton
    Left = 334
    Top = 128
    Width = 75
    Height = 25
    Cancel = True
    Caption = #21462#28040
    ModalResult = 2
    TabOrder = 2
  end
end
