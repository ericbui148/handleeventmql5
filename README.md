

A class containing 11 functions helps you to catch events occurring with an order.
In EA mq5, you use it as follows:

```cpp
//+------------------------------------------------------------------+
//| TradeTransaction function                                        |
//+------------------------------------------------------------------+
void OnTradeTransaction(const MqlTradeTransaction &trans,
                        const MqlTradeRequest &request,
                        const MqlTradeResult &result)
  {
   ETTradeTransaction * etTraderTransaction = new ETTradeTransaction();
   etTraderTransaction.OnTradeTransaction(trans, request, result);
  }
//+------------------------------------------------------------------+
```

---

If you need further assistance or any modifications, feel free to let me know!
```
Email: bthiep148@gmail.com
Tele: @ericb148
Linkedin: https://www.linkedin.com/in/hiep-eric-bui-26704030/
```
