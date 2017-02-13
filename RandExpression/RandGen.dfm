object FormGenRandom: TFormGenRandom
  Left = 297
  Top = 41
  BorderStyle = bsDialog
  Caption = '随机生成运算题'
  ClientHeight = 456
  ClientWidth = 440
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '宋体'
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
  object btn10AddSub2: TButton
    Left = 16
    Top = 16
    Width = 409
    Height = 25
    Caption = '生成 10 以内的二项加减法 90 题'
    TabOrder = 0
    OnClick = btn10AddSub2Click
  end
  object btn20AddSub2: TButton
    Left = 16
    Top = 56
    Width = 409
    Height = 25
    Caption = '生成 20 以内的二项加减法 90 题'
    TabOrder = 1
    OnClick = btn20AddSub2Click
  end
  object btn10Add2: TButton
    Left = 16
    Top = 96
    Width = 193
    Height = 25
    Caption = '生成 10 以内的二项加法 90 题'
    TabOrder = 2
    OnClick = btn10Add2Click
  end
  object btn10Sub2: TButton
    Left = 232
    Top = 96
    Width = 193
    Height = 25
    Caption = '生成 10 以内的二项减法 90 题'
    TabOrder = 3
    OnClick = btn10Sub2Click
  end
  object btn20Add2: TButton
    Left = 16
    Top = 136
    Width = 193
    Height = 25
    Caption = '生成 20 以内的二项加法 90 题'
    TabOrder = 4
    OnClick = btn20Add2Click
  end
  object btn20Sub2: TButton
    Left = 232
    Top = 136
    Width = 193
    Height = 25
    Caption = '生成 20 以内的二项减法 90 题'
    TabOrder = 5
    OnClick = btn20Sub2Click
  end
  object btnCompare10Add2vs1: TButton
    Left = 16
    Top = 200
    Width = 409
    Height = 25
    Caption = '生成 10 以内的二项加减法不等式 90 题'
    TabOrder = 6
    OnClick = btnCompare10Add2vs1Click
  end
  object btnCompare20AddSub2vs1: TButton
    Left = 16
    Top = 240
    Width = 409
    Height = 25
    Caption = '生成 20 以内的二项加减法不等式 90 题'
    TabOrder = 7
    OnClick = btnCompare20AddSub2vs1Click
  end
  object btn10AddSub2vs2: TButton
    Left = 16
    Top = 280
    Width = 193
    Height = 25
    Caption = '10 以内的双二项加减法不等式'
    TabOrder = 8
    OnClick = btn10AddSub2vs2Click
  end
  object btn20AddSub2vs2: TButton
    Left = 232
    Top = 280
    Width = 193
    Height = 25
    Caption = '20 以内的双二项加减法不等式'
    TabOrder = 9
    OnClick = btn20AddSub2vs2Click
  end
  object btnEqual10AddSub2vs2: TButton
    Left = 16
    Top = 368
    Width = 409
    Height = 25
    Caption = '生成 20 以内的二项加减法填空等式 90 题'
    TabOrder = 10
    OnClick = btnEqual10AddSub2vs2Click
  end
  object btnEqual20AddSub2vs2: TButton
    Left = 16
    Top = 328
    Width = 409
    Height = 25
    Caption = '生成 10 以内的二项加减法填空等式 90 题'
    TabOrder = 11
    OnClick = btnEqual20AddSub2vs2Click
  end
  object btnMulti10: TButton
    Left = 16
    Top = 408
    Width = 409
    Height = 25
    Caption = '生成 10 以内的二项乘法 90 题'
    TabOrder = 12
    OnClick = btnMulti10Click
  end
end
