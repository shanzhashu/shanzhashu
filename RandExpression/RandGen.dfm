object FormGenRandom: TFormGenRandom
  Left = 82
  Top = 117
  BorderStyle = bsDialog
  Caption = #38543#26426#29983#25104#36816#31639#39064
  ClientHeight = 456
  ClientWidth = 882
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClick = FormClick
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object bvl1: TBevel
    Left = 16
    Top = 180
    Width = 409
    Height = 17
    Shape = bsTopLine
  end
  object bvl2: TBevel
    Left = 16
    Top = 316
    Width = 409
    Height = 17
    Shape = bsTopLine
  end
  object bvl3: TBevel
    Left = 440
    Top = 16
    Width = 9
    Height = 417
    Shape = bsLeftLine
  end
  object btn10AddSub2: TButton
    Left = 16
    Top = 16
    Width = 409
    Height = 25
    Caption = #29983#25104' 10 '#20197#20869#30340#20108#39033#21152#20943#27861' 90 '#39064
    TabOrder = 0
    OnClick = btn10AddSub2Click
  end
  object btn20AddSub2: TButton
    Left = 16
    Top = 56
    Width = 409
    Height = 25
    Caption = #29983#25104' 20 '#20197#20869#30340#20108#39033#21152#20943#27861' 90 '#39064
    TabOrder = 1
    OnClick = btn20AddSub2Click
  end
  object btn10Add2: TButton
    Left = 16
    Top = 96
    Width = 193
    Height = 25
    Caption = #29983#25104' 10 '#20197#20869#30340#20108#39033#21152#27861' 90 '#39064
    TabOrder = 2
    OnClick = btn10Add2Click
  end
  object btn10Sub2: TButton
    Left = 232
    Top = 96
    Width = 193
    Height = 25
    Caption = #29983#25104' 10 '#20197#20869#30340#20108#39033#20943#27861' 90 '#39064
    TabOrder = 3
    OnClick = btn10Sub2Click
  end
  object btn20Add2: TButton
    Left = 16
    Top = 136
    Width = 193
    Height = 25
    Caption = #29983#25104' 20 '#20197#20869#30340#20108#39033#21152#27861' 90 '#39064
    TabOrder = 4
    OnClick = btn20Add2Click
  end
  object btn20Sub2: TButton
    Left = 232
    Top = 136
    Width = 193
    Height = 25
    Caption = #29983#25104' 20 '#20197#20869#30340#20108#39033#20943#27861' 90 '#39064
    TabOrder = 5
    OnClick = btn20Sub2Click
  end
  object btnCompare10Add2vs1: TButton
    Left = 16
    Top = 200
    Width = 409
    Height = 25
    Caption = #29983#25104' 10 '#20197#20869#30340#20108#39033#21152#20943#27861#19981#31561#24335' 90 '#39064
    TabOrder = 6
    OnClick = btnCompare10Add2vs1Click
  end
  object btnCompare20AddSub2vs1: TButton
    Left = 16
    Top = 240
    Width = 409
    Height = 25
    Caption = #29983#25104' 20 '#20197#20869#30340#20108#39033#21152#20943#27861#19981#31561#24335' 90 '#39064
    TabOrder = 7
    OnClick = btnCompare20AddSub2vs1Click
  end
  object btn10AddSub2vs2: TButton
    Left = 16
    Top = 280
    Width = 193
    Height = 25
    Caption = '10 '#20197#20869#30340#21452#20108#39033#21152#20943#27861#19981#31561#24335
    TabOrder = 8
    OnClick = btn10AddSub2vs2Click
  end
  object btn20AddSub2vs2: TButton
    Left = 232
    Top = 280
    Width = 193
    Height = 25
    Caption = '20 '#20197#20869#30340#21452#20108#39033#21152#20943#27861#19981#31561#24335
    TabOrder = 9
    OnClick = btn20AddSub2vs2Click
  end
  object btnEqual10AddSub2vs2: TButton
    Left = 16
    Top = 368
    Width = 409
    Height = 25
    Caption = #29983#25104' 20 '#20197#20869#30340#20108#39033#21152#20943#27861#22635#31354#31561#24335' 90 '#39064
    TabOrder = 10
    OnClick = btnEqual10AddSub2vs2Click
  end
  object btnEqual20AddSub2vs2: TButton
    Left = 16
    Top = 328
    Width = 409
    Height = 25
    Caption = #29983#25104' 10 '#20197#20869#30340#20108#39033#21152#20943#27861#22635#31354#31561#24335' 90 '#39064
    TabOrder = 11
    OnClick = btnEqual20AddSub2vs2Click
  end
  object btnMulti10: TButton
    Left = 16
    Top = 408
    Width = 409
    Height = 25
    Caption = #29983#25104' 10 '#20197#20869#30340#20108#39033#20056#27861' 90 '#39064
    TabOrder = 12
    OnClick = btnMulti10Click
  end
  object btnDiv100: TButton
    Left = 456
    Top = 56
    Width = 409
    Height = 25
    Caption = #29983#25104' 100 '#20197#20869#30340#20108#39033#38500#27861' 90 '#39064
    TabOrder = 13
    OnClick = btnDiv100Click
  end
  object btn10MulDiv2: TButton
    Left = 456
    Top = 96
    Width = 409
    Height = 25
    Caption = #29983#25104' 100 '#20197#20869#30340#20108#39033#20056#38500#27861' 90 '#39064
    TabOrder = 14
    OnClick = btn10MulDiv2Click
  end
  object btn100AddSub2: TButton
    Left = 456
    Top = 16
    Width = 409
    Height = 25
    Caption = #29983#25104' 100 '#20197#20869#30340#20108#39033#21152#20943#27861' 90 '#39064
    TabOrder = 15
    OnClick = btn100AddSub2Click
  end
  object btn10DivMod2: TButton
    Left = 456
    Top = 136
    Width = 409
    Height = 25
    Caption = #29983#25104' 100 '#20197#20869#30340#20108#39033#38500#27861#24102#20313#25968' 90 '#39064
    TabOrder = 16
    OnClick = btn10DivMod2Click
  end
end
