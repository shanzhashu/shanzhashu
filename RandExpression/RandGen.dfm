object FormGenRandom: TFormGenRandom
  Left = 369
  Top = 209
  BorderStyle = bsDialog
  Caption = '随机生成运算题'
  ClientHeight = 205
  ClientWidth = 440
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = '宋体'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
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
    Top = 64
    Width = 409
    Height = 25
    Caption = '生成 20 以内的二项加减法 90 题'
    TabOrder = 1
    OnClick = btn20AddSub2Click
  end
  object btn10Add2: TButton
    Left = 16
    Top = 112
    Width = 193
    Height = 25
    Caption = '生成 10 以内的二项加法 90 题'
    TabOrder = 2
    OnClick = btn10Add2Click
  end
  object btn10Sub2: TButton
    Left = 232
    Top = 112
    Width = 193
    Height = 25
    Caption = '生成 10 以内的二项减法 90 题'
    TabOrder = 3
    OnClick = btn10Sub2Click
  end
  object btn20Add2: TButton
    Left = 16
    Top = 152
    Width = 193
    Height = 25
    Caption = '生成 20 以内的二项加法 90 题'
    TabOrder = 4
    OnClick = btn20Add2Click
  end
  object btn20Sub2: TButton
    Left = 232
    Top = 152
    Width = 193
    Height = 25
    Caption = '生成 20 以内的二项减法 90 题'
    TabOrder = 5
    OnClick = btn20Sub2Click
  end
end
