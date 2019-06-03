# _Auto Boom — T.D. Stoneheart_

_Historical Vietnamese Crazy Arcade automation script for various in-game purposes._

---

## License synopsis

The script is available under GNU GPLv3 license. To be concise, the script can be examined, studied, modified, or reused, so long as the source code is made open, and the license and license text are kept intact.

Permissions of this strong copyleft license are conditioned on making available complete source code of licensed works and modifications, which include larger works using a licensed work, under the same license. Copyright and license notices must be preserved. Contributors provide an express grant of patent rights.

---

## About

Crazy Arcade was published in Vietnam (as _Boom Online_) in 2007 by VNG and unpublished in 2017. During the 2010s, automation solutions (with the most prominent one being _Auto Boom XTC_) of various scales emerged for various purposes, mainly boosting an account's number of wins or boosting guild points via quick winning. These automation scripts are mostly written in AutoHotKey and AutoIt scripting languages.

T.D. Stoneheart started his own baby steps with AutoIt automation in May 2014 and started his first script that automatically logs in to the game as the designated accounts. Afterwards, the script was steadily developed until a game client bug fix (?) in 2016 which thwarts all attempts to launch multiple instances of the game (Crazy Arcade is single-instance for a given PC). The script was abandoned ever since and stopped being useful. Even though the Vietnamese localization is unpublished, the automation script might still be useful in other Crazy Arcade localizations, but it requires further modifications due to localized text.

---

## Features

To understand what master and slave accounts mean, please refer to the _Key Terms_ section below.

* Auto tỉ lệ thắng _(Winning automation)_: Increases number of wins, win rate, and guild points (if master accounts are in the same guild).
* Auto điểm danh _(Check-in automation)_: Completes daily check-in procedures, including logging in, purchasing free needles, feeding pets, and finally logging out.
* Auto EXP/Level _(EXP/Level automation)_: Bring as many experience points as possible to the master account.
* Auto siêu cấp _(Ladder mode automation)_: Boosts master account's ladder rank by matching with slave account.
* Auto tỉ lệ thắng Zombie _(Winning automation with Zombie mode)_: Boosts guild points for all participants (wins are not recorded in Zombie mode). To combat with the unable to use multi-instance in one PC, this automation mode is used to connect with another machine, using host/guest indication in the automation settings.
* Single-instance mini-automation:
  * Auto chủ phòng _(Host automation)_: Presses the start button when everyone is ready.
  * Auto vật phẩm nhiệm vụ _(Quest item automation)_: Attempts to obtain all quest items dropped from the aircraft.
  * Auto câu cá _(Fishing automation)_: Performs fishing in the square.
  * Auto chợ trời _(Market automation)_: Purchases market items with user-defined conditions.
  * Auto tỉ lệ sặc _(Losing automation)_: Increases number of losses for all participants.
  * Auto đảo báu vật _(Treasure Island automation)_: Exhausts all existing Treasure Island dices.
  * Bug NPC Đấu trường quái vật _(Easy NPC bot bug)_: Generates an easier Leo NPC to assist in attaining SS rank.
* Multi-instance mini-automation (customizable number of participating instances):
  * Hỗ trợ siêu cấp _(Ladder mode assist)_: Push the start button quasi-simultaneously in all participants.
  * Auto chợ trời _(Market automation)_: Purchases the first possible market item. Slower than the single-instance counterpart.
  * Auto vật phẩm nhiệm vụ _(Quest item automation)_: Same functionality as that of the single-instance edition, although slower.
* Window tool: Rename, hide, or unhide a window, or change its transparency.

## Key Terms

* (Tài khoản) chính _(main/master account)_: The account that benefits from the boosts created from automation (e.g. winning).
* (Tài khoản) phụ _(auxiliary/sub/slave account)_: The account that takes the sacrifice so that the master account gains benefit in return (e.g. losing in a game against the master).

