object FormSetting: TFormSetting
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #36873#39033#35774#32622
  ClientHeight = 492
  ClientWidth = 646
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  ShowHint = True
  OnCreate = FormCreate
  DesignSize = (
    646
    492)
  PixelsPerInch = 96
  TextHeight = 12
  object pgcSetting: TPageControl
    Left = 8
    Top = 24
    Width = 631
    Height = 305
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
  end
  object btnClose: TButton
    Left = 563
    Top = 452
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #20851#38381
    TabOrder = 1
    OnClick = btnCloseClick
  end
  object pnlToolbar: TPanel
    Left = 563
    Top = 1
    Width = 81
    Height = 23
    BevelOuter = bvNone
    TabOrder = 2
    object btnAdd: TSpeedButton
      Left = 22
      Top = 0
      Width = 23
      Height = 22
      Hint = #22686#21152#36873#39033#31867#22411
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6BAD8421
        84292184296BAD84FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF63A56394DE8C39B552218429FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF63A56394
        DE8C39B552218429FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF63A56394DE8C39B552218429FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF63A56394
        DE8C39B552218429FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6BAD84
        21842921842921842921842921842994DE8C39B5522184292184292184292184
        292184296BAD84FF00FFFF00FF63A56339B55239B55239B55239B55239B55239
        B55239B55239B55239B55239B55239B55239B552218429FF00FFFF00FF63A563
        94DE8C94DE8C94DE8C94DE8C94DE8C94DE8C39B55294DE8C94DE8C94DE8C94DE
        8C94DE8C218429FF00FFFF00FF6BAD8463A56363A56363A56363A56363A56394
        DE8C39B5522184292184292184292184292184296BAD84FF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF63A56394DE8C39B552218429FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF63A56394
        DE8C39B552218429FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF63A56394DE8C39B552218429FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF63A56394
        DE8C39B552218429FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF6BAD8463A56363A5636BAD84FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      OnClick = btnAddClick
    end
    object btnDelete: TSpeedButton
      Left = 51
      Top = 0
      Width = 23
      Height = 22
      Hint = #21024#38500#36873#39033#31867#22411
      Flat = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6B84C6
        0021A50021A50021A50021A50021A50021A50021A50021A50021A50021A50021
        A50021A56B84C6FF00FFFF00FF0021A59494F70029E70029E70029E70029E700
        29E70029E70029E70029E70029E70029E70029E70021A5FF00FFFF00FF0021A5
        B5C6FF9CBDFF9CBDFF9CB5FF9CB5FF9CB5FF638CF7638CF7638CF7638CF7526B
        F7526BF70021A5FF00FFFF00FF6B84C60021A50021A50021A50021A50021A500
        21A50021A50021A50021A50021A50021A50021A56B84C6FF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      OnClick = btnDeleteClick
    end
  end
  object grpStamp: TGroupBox
    Left = 8
    Top = 344
    Width = 630
    Height = 89
    Anchors = [akLeft, akTop, akRight]
    Caption = #30422#31456#35774#32622
    TabOrder = 3
    object lbledtStampWidth: TLabeledEdit
      Left = 24
      Top = 40
      Width = 89
      Height = 20
      EditLabel.Width = 24
      EditLabel.Height = 12
      EditLabel.Caption = #23485#65306
      TabOrder = 0
    end
    object lbledtStampHeight: TLabeledEdit
      Left = 128
      Top = 40
      Width = 89
      Height = 20
      EditLabel.Width = 24
      EditLabel.Height = 12
      EditLabel.Caption = #39640#65306
      TabOrder = 1
    end
    object lbledtStampTop: TLabeledEdit
      Left = 232
      Top = 40
      Width = 89
      Height = 20
      EditLabel.Width = 60
      EditLabel.Height = 12
      EditLabel.Caption = #19978#32536#36317#31163#65306
      TabOrder = 2
    end
    object lbledtStampLeft: TLabeledEdit
      Left = 336
      Top = 40
      Width = 89
      Height = 20
      EditLabel.Width = 60
      EditLabel.Height = 12
      EditLabel.Caption = #24038#36793#36317#31163#65306
      TabOrder = 3
    end
  end
end
