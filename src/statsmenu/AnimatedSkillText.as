import Shared.GlobalFunc;
import Components.Meter;

class AnimatedSkillText extends MovieClip
{
   var SKILLS: Number = 18;
   var SKILL_ANGLE: Number = 20;
   var LocationsA: Array = [-150, -10, 130, 270, 410, 640, 870, 1010, 1150, 1290, 1430];
   var ThisInstance: AnimatedSkillText;

   function AnimatedSkillText()
   {
      super();
      ThisInstance = this;
   }

   function InitAnimatedSkillText(aSkillTextA: Array, aCapitalizeSkillNames: Boolean): Void
   {
      Shared.GlobalFunc.MaintainTextFormat();
      var arrayStride = 5; //_loc6_
      var i = 0; //_loc2_
      while(i < aSkillTextA.length)
      {
         var SkillText = undefined; //_loc3_
         if(this["SkillText" + i / arrayStride] != undefined)
         {
            SkillText = this["SkillText" + i / arrayStride];
         }
         else
         {
            SkillText = attachMovie("SkillText_mc","SkillText" + i / arrayStride, getNextHighestDepth());
         }
         SkillText.LabelInstance.html = true;
         var SkillName_RE = aSkillTextA[i + 1].toString(); //_loc5_
         if(aCapitalizeSkillNames)
         {
            SkillName_RE = SkillName_RE.toUpperCase();
         }
         SkillText.LabelInstance.htmlText = SkillName_RE + " <font face=\'$EverywhereBoldFont\' size=\'24\' color=\'" + aSkillTextA[i + 3].toString() + "\'>" + aSkillTextA[i].toString() + "</font>";
         var SkillMeter_RE = new Meter(SkillText.ShortBar);
         SkillMeter_RE.SetPercent(aSkillTextA[i + 2]);
         if(aSkillTextA[i + 4] > 0)
         {
            SkillText.LegendaryIconInfoInstance._alpha = 100;
            if(aSkillTextA[i + 4] > 1)
            {
               SkillText.LegendaryIconInfoInstance.LegendaryCountText.SetText(aSkillTextA[i + 4].toString(),false);
            }
            else
            {
               SkillText.LegendaryIconInfoInstance.LegendaryCountText.SetText("");
            }
         }
         else
         {
            SkillText.LegendaryIconInfoInstance._alpha = 0;
         }
         SkillText._x = LocationsA[0];
         i += arrayStride;
      }
   }

   function HideRing(): Void
   {
      var i = 0; //_loc2_
      while(i < SKILLS)
      {
         ThisInstance["SkillText" + i]._x = LocationsA[0];
         i = i + 1;
      }
   }

   function SetAngle(aAngle: Number): Void
   {
      var skillAngle: Number = Math.floor(aAngle / SKILL_ANGLE); //_loc6_
      var skillAngleRemainder_RE: Number = aAngle % SKILL_ANGLE / SKILL_ANGLE; //_loc10_
      var i = 0; //_loc2_
      while(i < SKILLS)
      {
         var _loc11_ = LocationsA.length - 2; //_loc11_
         var _loc5_ = Math.floor(_loc11_ / 2) + 1; //_loc5_
         var _loc4_ = skillAngle - _loc5_ < 0 ? skillAngle - _loc5_ + SKILLS : skillAngle - _loc5_; //_loc4_
         var _loc8_ = skillAngle + _loc5_ >= SKILLS ? skillAngle + _loc5_ - SKILLS : skillAngle + _loc5_; //_loc8_
         var _loc7_ = _loc4_ > _loc8_; //_loc7_
         if(!_loc7_ && (i > _loc4_ && i <= _loc8_) || _loc7_ && (i > _loc4_ || i <= _loc8_))
         {
            var _loc3_ = 0;
            if(!_loc7_)
            {
               _loc3_ = i - _loc4_;
            }
            else
            {
               _loc3_ = i <= _loc4_ ? i + (SKILLS - _loc4_) : i - _loc4_;
            }
            _loc3_ = _loc3_ - 1;
            ThisInstance["SkillText" + i]._x = Shared.GlobalFunc.Lerp(LocationsA[_loc3_], LocationsA[_loc3_ + 1], 1, 0, skillAngleRemainder_RE);
            var _loc9_ = (_loc3_ != 4 ? skillAngleRemainder_RE * 100 : 100 - skillAngleRemainder_RE * 100) * 0.75 + 100; //_loc9_
            ThisInstance["SkillText" + i]._xscale = !(_loc3_ == 5 || _loc3_ == 4) ? 100 : _loc9_;
            ThisInstance["SkillText" + i]._yscale = !(_loc3_ == 5 || _loc3_ == 4) ? 100 : _loc9_;
            ThisInstance["SkillText" + i].ShortBar._yscale = !(_loc3_ == 5 || _loc3_ == 4) ? 100 : 100 - (_loc9_ - 100) / 2.5;
         }
         else
         {
            ThisInstance["SkillText" + i]._x = LocationsA[0];
         }
         i = i + 1;
      }
   }
}
