unit in0k_lazarusIdeSRC__expertCORE;
{$mode objfpc}{$H+}

interface

{$include in0k_LazarusIdeSRC__Settings.inc}

uses {$ifDef in0k_LazarusIdeEXT__DEBUG}
     in0k_lazarusIdeSRC__wndDEBUG,
     {$endIf}
     LazIDEIntf;

type

  // САМО-регистрирующийся, САМО-отписывающийся и само-УНИЧТОЖАЮЩИЙСЯ
  // объект-експерт для Lazarus IDE.
 tIn0k_lazIdeSRC_expertCORE=class
  strict private
    procedure _On_IDE_Close_(Sender:TObject);
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

procedure tIn0k_lazIdeSRC_expertCORE.LazarusIDE_SetUP;
begin
    //
end;

procedure tIn0k_lazIdeSRC_expertCORE.LazarusIDE_CLEAN;
begin
    //
end;

//==============================================================================

procedure tIn0k_lazIdeSRC_expertCORE.AfterConstruction;
begin
    inherited;
   _Expert_SetUP_;
end;

procedure tIn0k_lazIdeSRC_expertCORE.BeforeDestruction;
begin
   _Expert_CLEAN_;
    inherited;
end;

//==============================================================================

procedure tIn0k_lazIdeSRC_expertCORE._Expert_CLEAN_;
begin
    //--- "пользовательское" ---
    LazarusIDE_CLEAN;
    //--------- СВОЕ -----------
    LazarusIDE.RemoveHandlerOnIDEClose(@_On_IDE_Close_);
    {$ifDef in0k_LazarusIdeEXT__DEBUG}
    // in0k_lazarusIdeSRC__wndDEBUG <--- оно САМО отпишется из IDE
    {$endIf}
end;

procedure tIn0k_lazIdeSRC_expertCORE._Expert_SetUP_;
begin
    //--- "пользовательское" ---
    LazarusIDE_SetUP;
    //--------- СВОЕ -----------
    LazarusIDE.AddHandlerOnIDEClose(@_On_IDE_Close_);
    {$ifDef in0k_LazarusIdeEXT__DEBUG}
    in0k_lazarusIdeSRC__wndDEBUG.SetUpInIDE(self.ClassNAME);
    {$endIf}
end;

//------------------------------------------------------------------------------

procedure tIn0k_lazIdeSRC_expertCORE._On_IDE_Close_(Sender:TObject);
begin {todo: может обратиться к помощи threadKILLer? или Application.QueueAsyncCall()}
    self.Destroy; //< ох .. и когда ж мне это аукнется? *^_^*
end;

end.

