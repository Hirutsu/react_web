import "../main.scss";
import { Link } from "react-router-dom";
import { useSelector } from "react-redux";
import SneakersItem from "./SneakersItem";

const Orders = () => {
  const ordersData = useSelector(({ orders }) => orders.orders);
  const userRole = useSelector(({ account }) => account.userRole);

  let orderedItems;

  if (ordersData.length > 0) {
    orderedItems = ordersData.map((item, index) => {
      return (
        <SneakersItem
          key={index}
          name={item.name}
          price={item.price}
          img={item.img}
          id={item.id}
          isOrdered
        />
      );
    });
  }

  return userRole !== "" ? (
    <div className="inner__page">
      <div className="container">
        {ordersData.length > 0 ? (
          <>
            <h2 className="main__title">
              <Link to="/">
                <img
                  src="/react-sneakers/img/arrow-back.jpg"
                  className="inner__page__back-btn"
                  alt="arrow back"
                />
              </Link>
              My orders
            </h2>
            <ul className="sneakers-list">{orderedItems}</ul>
          </>
        ) : (
          <div className="inner__page__empty">
            <img
              alt="orders empty"
              className="inner__page__empty__face"
              src="/react-sneakers/img/orders-empty.png"
            />
            <h3>No orders :(</h3>
            <p>
              Are you broke?
              <br />
              Order at least something
            </p>
            <Link to="/">
              <button
                type="button"
                className="green-button inner__page__empty__btn"
              >
                Go back
                <img alt="arrow" src="/react-sneakers/img/arrow.png" />
              </button>
            </Link>
          </div>
        )}
      </div>
    </div>
  ) : (
    <div className="container">
      <div style={{ display: "flex", justifyContent: "center", marginTop: 20 }}>
        Вы не зарегистрированы, войдите, чтобы посмотреть ваши заказы
      </div>
      <Link
        type="button"
        className="green-button cart__empty__button"
        to="/login"
        style={{ marginTop: 20, marginBottom: 20 }}
      >
        sing In
        <img alt="arrow" src="/react-sneakers/img/arrow.png" />
      </Link>
    </div>
  );
};

export default Orders;
