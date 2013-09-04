object DataModuleMain: TDataModuleMain
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 649
  Top = 93
  Height = 252
  Width = 347
  object dsOrderForms: TADODataSet
    Active = True
    Connection = conDatabase
    CursorType = ctStatic
    CommandText = 'select * from OrderForms'
    Parameters = <>
    Left = 48
    Top = 40
    object dsOrderFormsID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object dsOrderFormsBabyName: TWideStringField
      FieldName = 'BabyName'
      Size = 16
    end
    object dsOrderFormsAge: TIntegerField
      FieldName = 'Age'
    end
    object dsOrderFormsContactNum: TWideStringField
      FieldName = 'ContactNum'
      Size = 32
    end
    object dsOrderFormsOrderDate: TDateTimeField
      FieldName = 'OrderDate'
    end
    object dsOrderFormsPrice: TIntegerField
      FieldName = 'Price'
    end
    object dsOrderFormsPayment: TIntegerField
      FieldName = 'Payment'
    end
    object dsOrderFormsShotTime: TIntegerField
      FieldName = 'ShotTime'
    end
    object dsOrderFormsShotDate: TDateTimeField
      FieldName = 'ShotDate'
    end
    object dsOrderFormsDesignName: TIntegerField
      FieldName = 'DesignName'
    end
    object dsOrderFormsDesignSendDate: TDateTimeField
      FieldName = 'DesignSendDate'
    end
    object dsOrderFormsDesignReceiveDate: TDateTimeField
      FieldName = 'DesignReceiveDate'
    end
    object dsOrderFormsFactoryName: TIntegerField
      FieldName = 'FactoryName'
    end
    object dsOrderFormsSendToFactoryDate: TDateTimeField
      FieldName = 'SendToFactoryDate'
    end
    object dsOrderFormsRecvFromFactoryDate: TDateTimeField
      FieldName = 'RecvFromFactoryDate'
    end
    object dsOrderFormsCustomerTakenDate: TDateTimeField
      FieldName = 'CustomerTakenDate'
    end
    object dsOrderFormsStatus: TIntegerField
      FieldName = 'Status'
    end
    object dsOrderFormsPicContent: TMemoField
      FieldName = 'PicContent'
      BlobType = ftMemo
    end
    object dsOrderFormsMemory: TWideStringField
      FieldName = 'Memory'
      Size = 255
    end
    object dsOrderFormsDesignNameText: TStringField
      FieldKind = fkLookup
      FieldName = 'DesignNameText'
      LookupDataSet = tblDesignNames
      LookupKeyFields = 'ID'
      LookupResultField = 'DesignName'
      KeyFields = 'DesignName'
      Size = 64
      Lookup = True
    end
    object dsOrderFormsFactoryNameText: TStringField
      FieldKind = fkLookup
      FieldName = 'FactoryNameText'
      LookupDataSet = tblFactoryNames
      LookupKeyFields = 'ID'
      LookupResultField = 'FactoryName'
      KeyFields = 'FactoryName'
      Size = 64
      Lookup = True
    end
    object dsOrderFormsStatusText: TStringField
      FieldKind = fkLookup
      FieldName = 'StatusText'
      LookupDataSet = tblStatusStrings
      LookupKeyFields = 'Status'
      LookupResultField = 'StatusDescription'
      KeyFields = 'Status'
      Size = 32
      Lookup = True
    end
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
    Active = True
    Connection = conDatabase
    CursorType = ctStatic
    TableName = 'StatusStrings'
    Left = 232
    Top = 128
  end
end
