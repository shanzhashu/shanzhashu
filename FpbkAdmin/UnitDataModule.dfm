object DataModuleMain: TDataModuleMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 649
  Top = 93
  Height = 252
  Width = 347
  object dsOrderForms: TADODataSet
    Connection = conDatabase
    Parameters = <>
    Left = 48
    Top = 40
  end
  object conDatabase: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.ACE.OLEDB.12.0;Data Source=Database.mdb;Persi' +
      'st Security Info=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.ACE.OLEDB.12.0'
    Left = 144
    Top = 40
  end
  object tblDesignNames: TADOTable
    Active = True
    Connection = conDatabase
    CursorType = ctStatic
    TableName = 'DesignNames'
    Left = 48
    Top = 128
  end
  object tblFactoryNames: TADOTable
    Active = True
    Connection = conDatabase
    CursorType = ctStatic
    TableName = 'FactoryNames'
    Left = 144
    Top = 128
  end
  object tblStatusStrings: TADOTable
    Connection = conDatabase
    TableName = 'StatusStrings'
    Left = 232
    Top = 128
  end
end
