import { useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import { Link, useNavigate } from "react-router-dom";
import Authorize from "../Api/Authorize";
import "../main.scss";
import { setIsSign, setName, setRole } from "../store/accoutSlice";
import { changeCartStatus } from "../store/cartStatusSlice";

const LogIn = () => {
  const [log, setLog] = useState();
  const [pass, setPass] = useState();
  const navigate = useNavigate();
  const dispatch = useDispatch();
  const isSign = useSelector(({ account }) => account.isSign);

  const signIn = (e) => {
    e.preventDefault();
    const account = {
      login: log,
      password: pass,
    };
    const response = authorize(account).then((data) => {
      sessionStorage.setItem("access_token", data.data.access_token);
      sessionStorage.setItem("user_name", data.data.user_name);
      sessionStorage.setItem("user_role", data.data.user_role);
      dispatch(setIsSign(true));
      dispatch(setName(data.data.user_name));
      dispatch(setRole(data.data.user_role));
    });
  };

  async function authorize(account) {
    return await Authorize.authorize(account);
  }

  return (
    <div className="inner__page">
      <div className="container">
        {!isSign ? (
          <div>
            Вход в аккаунт
            <form onSubmit={signIn}>
              <p>
                Login:{" "}
                <input
                  type="username"
                  id="username"
                  name="username"
                  value={log}
                  onChange={(el) => setLog(el.target.value)}
                />
              </p>
              <p>
                Password:{" "}
                <input
                  type="password"
                  id="password"
                  name="password"
                  value={pass}
                  onChange={(el) => setPass(el.target.value)}
                />
              </p>
              <input type="submit" />
            </form>
          </div>
        ) : (
          <div>
            <div style={{ display: "flex", justifyContent: "center" }}>
              Вы зашли в аккаунт, нажмите на кнопку чтобы вернуться обратно
            </div>
            <Link
              onClick={() => dispatch(changeCartStatus(false))}
              type="button"
              className="green-button cart__empty__button"
              to="/"
              style={{ marginTop: 20, marginBottom: 20 }}
            >
              Go back
              <img alt="arrow" src="/react-sneakers/img/arrow.png" />
            </Link>
          </div>
        )}
      </div>
    </div>
  );
};

export default LogIn;
