import { act } from "react-dom/test-utils";
import "../../main.scss";

const Modal = ({ active, setActive, children }) => {
  return (
    <div
      className={active ? "modal active" : "modal"}
      onClick={() => setActive(false)}
    >
      <div
        onClick={(e) => e.stopPropagation()}
        className={active ? "modal__content active" : "modal__content"}
      >
        {children}
      </div>
    </div>
  );
};

export default Modal;
