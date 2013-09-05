object FormOrderDetail: TFormOrderDetail
  Left = 432
  Top = 284
  Width = 647
  Height = 538
  Caption = #35746#21333#35814#24773
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object lblStatus: TLabel
    Left = 8
    Top = 132
    Width = 60
    Height = 12
    Caption = #35746#21333#29366#24577#65306
    Font.Charset = GB2312_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object bvl1: TBevel
    Left = 208
    Top = 128
    Width = 417
    Height = 9
    Shape = bsBottomLine
  end
  object lblOrderDetail: TLabel
    Left = 208
    Top = 132
    Width = 6
    Height = 12
  end
  object grpDesign: TGroupBox
    Left = 8
    Top = 328
    Width = 297
    Height = 129
    Caption = #35774#35745#30456#20851
    TabOrder = 3
    object lblDesignName: TLabel
      Left = 16
      Top = 28
      Width = 60
      Height = 12
      Caption = #35774#35745#20844#21496#65306
    end
    object lblDesignSend: TLabel
      Left = 16
      Top = 60
      Width = 60
      Height = 12
      Caption = #21457#20986#26085#26399#65306
    end
    object lblRecvDesign: TLabel
      Left = 16
      Top = 92
      Width = 60
      Height = 12
      Caption = #23436#31295#26085#26399#65306
    end
    object cbbDesignName: TComboBox
      Left = 80
      Top = 24
      Width = 193
      Height = 20
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 0
    end
    object dtpDesignSend: TDateTimePicker
      Left = 80
      Top = 56
      Width = 97
      Height = 20
      Date = 2.594985127318068000
      Time = 2.594985127318068000
      TabOrder = 1
    end
    object dtpRecvDesign: TDateTimePicker
      Left = 80
      Top = 88
      Width = 97
      Height = 20
      Date = 41520.594985127320000000
      Time = 41520.594985127320000000
      TabOrder = 2
    end
  end
  object grpFactory: TGroupBox
    Left = 328
    Top = 328
    Width = 297
    Height = 129
    Caption = #21046#20316#30456#20851
    TabOrder = 4
    object lblFactoryName: TLabel
      Left = 16
      Top = 28
      Width = 60
      Height = 12
      Caption = #21046#20316#20844#21496#65306
    end
    object lblSendToFactory: TLabel
      Left = 16
      Top = 60
      Width = 60
      Height = 12
      Caption = #21457#20986#26085#26399#65306
    end
    object lblRecvFromFactory: TLabel
      Left = 16
      Top = 92
      Width = 60
      Height = 12
      Caption = #20132#36135#26085#26399#65306
    end
    object cbbFactoryName: TComboBox
      Left = 80
      Top = 24
      Width = 193
      Height = 20
      Style = csDropDownList
      ItemHeight = 12
      TabOrder = 0
    end
    object dtpSendToFactory: TDateTimePicker
      Left = 80
      Top = 56
      Width = 97
      Height = 20
      Date = 41520.594985127320000000
      Time = 41520.594985127320000000
      TabOrder = 1
    end
    object dtpRecvFromFactory: TDateTimePicker
      Left = 80
      Top = 88
      Width = 97
      Height = 20
      Date = 41520.594985127320000000
      Time = 41520.594985127320000000
      TabOrder = 2
    end
  end
  object grpBaby: TGroupBox
    Left = 8
    Top = 16
    Width = 617
    Height = 97
    Caption = #22522#26412#20449#24687
    TabOrder = 0
    object lblBabyName: TLabel
      Left = 16
      Top = 24
      Width = 60
      Height = 12
      Caption = #23453#23453#22995#21517#65306
    end
    object lblContactNum: TLabel
      Left = 192
      Top = 24
      Width = 60
      Height = 12
      Caption = #32852#31995#26041#24335#65306
    end
    object lblOrderDate: TLabel
      Left = 16
      Top = 56
      Width = 60
      Height = 12
      Caption = #19979#35746#26085#26399#65306
    end
    object lblShotDate: TLabel
      Left = 192
      Top = 56
      Width = 60
      Height = 12
      Caption = #25293#29031#26085#26399#65306
    end
    object lblHour1: TLabel
      Left = 400
      Top = 56
      Width = 12
      Height = 12
      Caption = #28857
    end
    object lblTaken: TLabel
      Left = 432
      Top = 56
      Width = 60
      Height = 12
      Caption = #21462#20214#26085#26399#65306
    end
    object lblAge: TLabel
      Left = 408
      Top = 24
      Width = 60
      Height = 12
      Caption = #23453#23453#24180#40836#65306
    end
    object edtBabyName: TEdit
      Left = 80
      Top = 20
      Width = 97
      Height = 20
      TabOrder = 0
    end
    object edtContactNum: TEdit
      Left = 256
      Top = 20
      Width = 137
      Height = 20
      TabOrder = 1
    end
    object dtpOrderDate: TDateTimePicker
      Left = 80
      Top = 52
      Width = 97
      Height = 20
      Date = 41520.594985127320000000
      Time = 41520.594985127320000000
      TabOrder = 3
    end
    object dtpShotDate: TDateTimePicker
      Left = 256
      Top = 52
      Width = 97
      Height = 20
      Date = 41520.594985127320000000
      Time = 41520.594985127320000000
      TabOrder = 4
      OnChange = dtpShotDateChange
    end
    object seOrderDate: TSpinEdit
      Left = 356
      Top = 52
      Width = 37
      Height = 21
      MaxValue = 20
      MinValue = 8
      TabOrder = 5
      Value = 8
    end
    object dtpTakenDate: TDateTimePicker
      Left = 496
      Top = 52
      Width = 97
      Height = 20
      Date = 41520.594985127320000000
      Time = 41520.594985127320000000
      TabOrder = 6
    end
    object edtAge: TEdit
      Left = 472
      Top = 20
      Width = 121
      Height = 20
      TabOrder = 2
    end
  end
  object grpContent: TGroupBox
    Left = 8
    Top = 160
    Width = 617
    Height = 153
    Caption = #22871#39184#20869#23481
    TabOrder = 2
    object lblPrice: TLabel
      Left = 16
      Top = 32
      Width = 60
      Height = 12
      Caption = #22871#39184#37329#39069#65306
    end
    object lblPayment: TLabel
      Left = 16
      Top = 64
      Width = 60
      Height = 12
      Caption = #24050#20184#37329#39069#65306
    end
    object lblContent: TLabel
      Left = 112
      Top = 100
      Width = 60
      Height = 12
      Caption = #22871#39184#20869#23481#65306
    end
    object btnFillSuite: TSpeedButton
      Left = 56
      Top = 96
      Width = 23
      Height = 22
      Hint = #36873#25321#39044#32622#30340#22871#39184
      OnClick = btnFillSuiteClick
    end
    object edtPrice: TEdit
      Left = 80
      Top = 28
      Width = 89
      Height = 20
      TabOrder = 0
    end
    object edtPayment: TEdit
      Left = 80
      Top = 60
      Width = 89
      Height = 20
      TabOrder = 2
    end
    object mmoContent: TMemo
      Left = 200
      Top = 28
      Width = 393
      Height = 101
      TabOrder = 1
    end
  end
  object cbbStatus: TComboBox
    Left = 88
    Top = 128
    Width = 97
    Height = 20
    Style = csDropDownList
    ItemHeight = 12
    TabOrder = 1
    OnChange = cbbStatusChange
  end
  object btnCancel: TBitBtn
    Left = 550
    Top = 472
    Width = 75
    Height = 25
    Caption = #21462#28040
    TabOrder = 5
    Kind = bkCancel
  end
  object btnOK: TBitBtn
    Left = 446
    Top = 472
    Width = 75
    Height = 25
    Caption = #20445#23384
    Default = True
    TabOrder = 6
    OnClick = btnOKClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
end
