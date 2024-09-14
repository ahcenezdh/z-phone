import { useContext, useEffect, useState } from "react";
import axios from "axios";
import MenuContext from "../../context/MenuContext";
import {
  LOOPS_DETAIL,
  LOOPS_PROFILE,
  LOOPS_SIGNIN,
  LOOPS_SIGNUP,
  LOOPS_TESTING,
  LOOPS_TWEETS,
  LOOPS_LOCAL_STORAGE_IS_AUTH,
  LOOPS_POST,
} from "./loops_constant";
import LoopsTweetsComponent from "./LoopsTweetsComponent";
import LoopsDetailComponent from "./LoopsDetailComponent";
import LoopsProfileComponent from "./LoopsProfileComponent";
import LoopsSigninComponent from "./LoopsSigninComponent";
import LoopsSignupComponent from "./LoopsSignupComponent";
import LoopPostComponent from "./LoopPostComponent";

const LoopsComponent = ({ isShow }) => {
  const { resolution, profile, tweets, setTweets, setMenu } =
    useContext(MenuContext);
  const [subMenu, setSubMenu] = useState(LOOPS_SIGNIN);
  const [selectedTweet, setSelectedTweet] = useState(null);

  const checkAuth = () => {
    const isAuth = localStorage.getItem(LOOPS_LOCAL_STORAGE_IS_AUTH);
    if ([LOOPS_SIGNIN, LOOPS_SIGNUP].includes(subMenu)) {
      if (isAuth == "ok") {
        setSubMenu(LOOPS_TWEETS);
      }
    } else {
      if (isAuth != "ok") {
        setSubMenu(LOOPS_SIGNIN);
      }
    }
  };

  useEffect(() => {
    checkAuth();
  }, [subMenu]);

  useEffect(() => {
    console.log("ok");
  }, []);

  return (
    <div
      className="relative w-full h-full"
      style={{
        display: isShow ? "block" : "none",
      }}
    >
      <LoopPostComponent
        isShow={subMenu == LOOPS_POST}
        setSubMenu={setSubMenu}
      />
      <LoopsTweetsComponent
        isShow={subMenu == LOOPS_TWEETS}
        setSubMenu={setSubMenu}
        setSelectedTweet={setSelectedTweet}
      />
      <LoopsDetailComponent
        isShow={subMenu == LOOPS_DETAIL}
        setSubMenu={setSubMenu}
        selectedTweet={selectedTweet}
        setSelectedTweet={setSelectedTweet}
      />
      <LoopsProfileComponent
        isShow={subMenu == LOOPS_PROFILE}
        setSubMenu={setSubMenu}
        setSelectedTweet={setSelectedTweet}
      />
      <LoopsSigninComponent
        isShow={subMenu == LOOPS_SIGNIN}
        setSubMenu={setSubMenu}
      />
      <LoopsSignupComponent
        isShow={subMenu == LOOPS_SIGNUP}
        setSubMenu={setSubMenu}
      />
    </div>
  );
};
export default LoopsComponent;
