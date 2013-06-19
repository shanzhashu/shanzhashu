object FormMain: TFormMain
  Left = 204
  Top = 136
  BorderStyle = bsDialog
  Caption = #25913#29031#29255#30340#24037#20855
  ClientHeight = 396
  ClientWidth = 566
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object lbl1: TLabel
    Left = 24
    Top = 24
    Width = 60
    Height = 12
    Caption = #22788#29702#30446#24405#65306
  end
  object Bevel1: TBevel
    Left = 24
    Top = 112
    Width = 521
    Height = 17
    Shape = bsBottomLine
  end
  object edtSource: TEdit
    Left = 88
    Top = 20
    Width = 369
    Height = 20
    TabOrder = 0
  end
  object btnBrowseSrc: TButton
    Left = 472
    Top = 20
    Width = 75
    Height = 21
    Caption = #36873#25321#30446#24405
    TabOrder = 1
    OnClick = btnBrowseSrcClick
  end
  object btnDo: TButton
    Left = 24
    Top = 344
    Width = 521
    Height = 25
    Caption = #25913#65281#25913#65281#65281#25913#65281#65281#65281
    TabOrder = 5
    OnClick = btnDoClick
  end
  object chkRecure: TCheckBox
    Left = 88
    Top = 56
    Width = 113
    Height = 17
    Caption = #22788#29702#19979#32423#23376#30446#24405
    TabOrder = 3
  end
  object chkDeleteBack: TCheckBox
    Left = 304
    Top = 56
    Width = 153
    Height = 17
    Caption = #19981#22791#20221#25991#20214
    Checked = True
    State = cbChecked
    TabOrder = 4
  end
  object chkAutoRotate: TCheckBox
    Left = 24
    Top = 176
    Width = 521
    Height = 17
    Caption = #23558#29031#29255#33258#21160#26059#36716#21040#27491#30830#26041#21521
    Checked = True
    State = cbChecked
    TabOrder = 2
  end
  object GroupBox1: TGroupBox
    Left = 24
    Top = 216
    Width = 521
    Height = 105
    TabOrder = 6
    OnDblClick = GroupBox1DblClick
    object lbl2: TLabel
      Left = 24
      Top = 65
      Width = 60
      Height = 12
      Caption = #26426#22411#25913#25104#65306
      Visible = False
    end
    object cbbModel: TComboBox
      Left = 88
      Top = 61
      Width = 409
      Height = 20
      Enabled = False
      ItemHeight = 12
      TabOrder = 0
      Visible = False
      Items.Strings = (
        'Canon EOS 7D'
        'Canon EOS 5D Mark II'
        'Canon EOS 5D Mark III'
        'Canon EOS 1DX'
        'Canon EOS 60D')
    end
    object chkChangeCamara: TCheckBox
      Left = 24
      Top = 32
      Width = 113
      Height = 17
      Caption = #20462#25913#26426#22411
      TabOrder = 1
      Visible = False
      OnClick = chkChangeCamaraClick
    end
  end
  object chkResize: TCheckBox
    Left = 24
    Top = 144
    Width = 161
    Height = 17
    Caption = #32553#25918#29031#29255#23610#23544#33267
    TabOrder = 7
    OnClick = chkResizeClick
  end
  object chkErrorAbort: TCheckBox
    Left = 88
    Top = 88
    Width = 249
    Height = 17
    Caption = #20986#38169#26102#20572#27490#21518#32493#30340#29031#29255#22788#29702
    Checked = True
    State = cbChecked
    TabOrder = 8
  end
  object cbbResizeGeo: TComboBox
    Left = 216
    Top = 141
    Width = 329
    Height = 20
    Enabled = False
    ItemHeight = 12
    TabOrder = 9
    Text = '4080x2720 - '#20840#24133'M'
    Items.Strings = (
      '2784x1856 - '#20840#24133'S'
      '4080x2720 - '#20840#24133'M'
      '5616x3744 - '#20840#24133'L'
      '2592x1728 - '#38750#20840#24133'S'
      '3456x2304 - '#38750#20840#24133'M'
      '5184x3456 - '#38750#20840#24133'L')
  end
end
