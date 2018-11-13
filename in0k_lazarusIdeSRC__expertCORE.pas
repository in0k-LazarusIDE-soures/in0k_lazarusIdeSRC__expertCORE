unit in0k_lazarusIdeSRC__expertCORE;
{$mode objfpc}{$H+}

interface

{$include in0k_LazarusIdeSRC__Settings.inc}

uses {$ifDef in0k_LazarusIdeEXT__DEBUG}
     in0k_lazarusIdeSRC__wndDEBUG,
     {$endIf}
     IDEIntf, LazIDEIntf;

type

 tIn0k_lazIdeSRC_expertCORE=class
  private
    procedure _On_IDE_Close_({%H-}Sender:TObject);
    procedure _Expert_CLEAN_; inline;
    procedure _Expert_SetUP_; inline;
  protected
    procedure LazarusIDE_SetUP; virtual;
    procedure LazarusIDE_CLEAN; virtual;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

implementation

procedure tIn0k_lazIdeSRC_expertCORE.AfterConstruction;
begin
    inherited;
   _Expert_SetUP_;
end;

procedure tIn0k_lazIdeSRC_expertCORE.BeforeDestruction;
begin
    inherited;
   _Expert_CLEAN_;
end;

//------------------------------------------------------------------------------

procedure tIn0k_lazIdeSRC_expertCORE._Expert_CLEAN_;
begin
    LazarusIDE.RemoveHandlerOnIDEClose(@_On_IDE_Close_);
    LazarusIDE_CLEAN;
end;

procedure tIn0k_lazIdeSRC_expertCORE._Expert_SetUP_;
begin
    LazarusIDE.AddHandlerOnIDEClose(@_On_IDE_Close_);
    LazarusIDE_SetUP;
end;

//------------------------------------------------------------------------------

procedure tIn0k_lazIdeSRC_expertCORE._On_IDE_Close_({%H-}Sender:TObject);
begin
    FREE;
end;

//------------------------------------------------------------------------------

procedure tIn0k_lazIdeSRC_expertCORE.LazarusIDE_SetUP;
begin
    {$ifDef in0k_LazarusIdeEXT__DEBUG}
    in0k_lazarusIdeSRC__wndDEBUG.SetUpInIDE(self.ClassNAME);
    {$endIf}
end;

procedure tIn0k_lazIdeSRC_expertCORE.LazarusIDE_CLEAN;
begin
    {$ifDef in0k_LazarusIdeEXT__DEBUG}
    // in0k_lazarusIdeSRC__wndDEBUG <--- оно САМО отпишется из IDE
    {$endIf}
end;

end.

