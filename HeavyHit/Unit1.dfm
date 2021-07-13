object FormHit: TFormHit
  Left = 327
  Top = 105
  Width = 767
  Height = 589
  Caption = 'Heavy Hit Chicken 0.01'
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  DesignSize = (
    759
    562)
  PixelsPerInch = 96
  TextHeight = 12
  object pbHit: TPaintBox
    Left = 0
    Top = 0
    Width = 409
    Height = 562
    Align = alLeft
    Anchors = [akLeft, akTop, akRight, akBottom]
    OnClick = pbHitClick
    OnMouseDown = pbHitMouseDown
    OnMouseMove = pbHitMouseMove
    OnMouseUp = pbHitMouseUp
    OnPaint = pbHitPaint
  end
  object rgHitMode: TRadioGroup
    Left = 424
    Top = 8
    Width = 321
    Height = 73
    Anchors = [akTop, akRight]
    Caption = #24377#36947#31867#22411
    Items.Strings = (
      #30452#32447#29256
      #26354#32447#29256)
    TabOrder = 0
    OnClick = rgHitModeClick
  end
  object grpParam: TGroupBox
    Left = 424
    Top = 96
    Width = 321
    Height = 233
    Anchors = [akTop, akRight]
    Caption = #21442#25968
    TabOrder = 1
    object lblR: TLabel
      Left = 16
      Top = 24
      Width = 60
      Height = 12
      Caption = #33988#21147#21306#21322#24452
    end
    object lblSita: TLabel
      Left = 16
      Top = 48
      Width = 60
      Height = 12
      Caption = #33988#21147#21306#20559#35282
    end
    object lblW: TLabel
      Left = 16
      Top = 96
      Width = 48
      Height = 12
      Caption = #40481#21306#23485#24230
    end
    object lblH: TLabel
      Left = 16
      Top = 120
      Width = 48
      Height = 12
      Caption = #40481#21306#39640#24230
    end
    object lblDegree: TLabel
      Left = 232
      Top = 48
      Width = 12
      Height = 12
      Caption = #24230
    end
    object lblD: TLabel
      Left = 16
      Top = 144
      Width = 60
      Height = 12
      Caption = #33853#28857#21306#20869#24452
    end
    object lblP: TLabel
      Left = 16
      Top = 168
      Width = 84
      Height = 12
      Caption = #33853#28857#21306#40481#21306#36317#31163
    end
    object lblB: TLabel
      Left = 16
      Top = 72
      Width = 60
      Height = 12
      Caption = #33988#21147#21306#24213#36317
    end
    object edtR: TEdit
      Left = 104
      Top = 20
      Width = 121
      Height = 20
      TabOrder = 0
      Text = '100'
    end
    object edtSita: TEdit
      Left = 104
      Top = 44
      Width = 121
      Height = 20
      TabOrder = 1
      Text = '75'
    end
    object edtW: TEdit
      Left = 104
      Top = 92
      Width = 121
      Height = 20
      TabOrder = 2
      Text = '250'
    end
    object edtH: TEdit
      Left = 104
      Top = 116
      Width = 121
      Height = 20
      TabOrder = 3
      Text = '150'
    end
    object chkW: TCheckBox
      Left = 232
      Top = 96
      Width = 81
      Height = 17
      Caption = #20351#29992#23631#24149#23485
      TabOrder = 4
    end
    object edtD: TEdit
      Left = 104
      Top = 140
      Width = 121
      Height = 20
      TabOrder = 5
      Text = '100'
    end
    object edtP: TEdit
      Left = 104
      Top = 164
      Width = 121
      Height = 20
      TabOrder = 6
      Text = '50'
    end
    object btnApply: TButton
      Left = 16
      Top = 192
      Width = 289
      Height = 21
      Caption = #24212#29992
      TabOrder = 7
      OnClick = btnApplyClick
    end
    object edtB: TEdit
      Left = 104
      Top = 68
      Width = 121
      Height = 20
      TabOrder = 8
      Text = '50'
    end
  end
end
