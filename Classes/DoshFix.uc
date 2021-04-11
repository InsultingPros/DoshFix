class DoshFix extends Mutator;


var bool bFlag;


event PreBeginPlay()
{
  super.PreBeginPlay();

  if (KFGameType(Level.Game) == none)
	{
		Log(">>> DoshFix Mutator: KFGameType not found, terminating!");
    destroy();
	}
}


function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
  // filter the cash and do our magic, thanks dkanus
  if (CashPickup(other) != none)
  {
    if (bFlag)
    {
      class'CashPickup'.default.bHighDetail = true;
      // 0.3 is the most ideal value - fixes all issues
      // and aint that slow at same time
      SetTimer(0.3f, false);
      bFlag = false;
    }
  }

  // don't break the chain!
  return super.CheckReplacement(Other, bSuperRelevant);
}


function Timer()
{
  class'CashPickup'.default.bHighDetail = false;
  bFlag = true;
}


// just in case game dies during Timer
event Destroyed()
{
  // restore original settings
  class'CashPickup'.default.bHighDetail = false;
  super.Destroyed();
}


defaultproperties
{
  GroupName="KF-DoshFix"
  FriendlyName="Dosh Fix Mutator"
  Description="Prevents dosh spam related exploits - server lags, server crash, blocking volume bypass, zed kills, etc."
  bFlag=true
}