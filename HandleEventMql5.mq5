//+------------------------------------------------------------------+
//|                                           ETTradeTransaction.mqh |
//|                              Copyright 2024, Eric Trader Company |
//|                                           https://erictrader.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2024, Eric Trader Company"
#property link      "https://erictrader.com"
#property version   "1.00"

//+------------------------------------------------------------------+
//| Class ETTradeTransaction.                                         |
//| Purpose: Base class for trade transactions.                      |
//+------------------------------------------------------------------+
class ETTradeTransaction
  {
public:
                     ETTradeTransaction(ETParameter * mParameter);
   void              OnTradeTransaction(const MqlTradeTransaction &trans,
                                        const MqlTradeRequest &request,
                                        const MqlTradeResult &result);
protected:
   bool      IsTradeTransactionOrderPlaced(const MqlTradeTransaction &trans, const MqlTradeRequest &request, const MqlTradeResult &result);
   bool      IsTradeTransactionOrderModified(const MqlTradeTransaction &trans, const MqlTradeRequest &request, const MqlTradeResult &result);
   bool      IsTradeTransactionOrderDeleted(const MqlTradeTransaction &trans);
   bool      IsTradeTransactionOrderExpired(const MqlTradeTransaction &trans);
   bool      IsTradeTransactionOrderTriggered(const MqlTradeTransaction &trans);
   bool      IsTradeTransactionPositionOpened(const MqlTradeTransaction &trans);
   bool      IsTradeTransactionPositionClosedByHedge(const MqlTradeTransaction &trans);
   bool      IsTradeTransactionPositionClosedByStopTake(const MqlTradeTransaction &trans);
   bool      IsTradeTransactionPositionClosed(const MqlTradeTransaction &trans);
   bool      IsTradeTransactionPositionCloseBy(const MqlTradeTransaction &trans);
   bool      IsTradeTransactionPositionModified(const MqlTradeTransaction &trans, const MqlTradeRequest &request);


  };
//+------------------------------------------------------------------+
//| Method of verification of trade transactions.                    |
//+------------------------------------------------------------------+
void ETTradeTransaction::OnTradeTransaction(const MqlTradeTransaction &trans,
                                           const MqlTradeRequest &request,
                                           const MqlTradeResult &result)
  {
   if(IsTradeTransactionOrderPlaced(trans, request, result)) 
   {
	  //To do
   }

   else if(IsTradeTransactionOrderModified(trans, request, result))
   {
	 //To do
   }

   else if(IsTradeTransactionOrderDeleted(trans)) 
   {
	 //To do
   }         
      
   else if(IsTradeTransactionOrderExpired(trans))
   {
	 //To do
   }           

   else if(IsTradeTransactionOrderTriggered(trans))
   {
	//To do
   }       

   else if(IsTradeTransactionPositionOpened(trans))
   {
	 //To do
   }
      
   else if (IsTradeTransactionPositionClosedByHedge(trans)) 
   {
	 //To do
   }
   
   else if(IsTradeTransactionPositionClosedByStopTake(trans))
   {
	 //To do
   }         

   else if(IsTradeTransactionPositionClosed(trans))
   {
	 //To do
   }      

   else if(IsTradeTransactionPositionCloseBy(trans))
   {
	//To do
   }         

   else if(IsTradeTransactionPositionModified(trans, request))
   {
	 //To do
   }
  }
//+------------------------------------------------------------------+

bool ETTradeTransaction::IsTradeTransactionOrderPlaced(const MqlTradeTransaction &trans, const MqlTradeRequest &request, const MqlTradeResult &result )
{
   return trans.type == TRADE_TRANSACTION_REQUEST 
         && request.action == TRADE_ACTION_PENDING 
         && OrderSelect(result.order) 
         && (ENUM_ORDER_STATE)OrderGetInteger(ORDER_STATE) == ORDER_STATE_PLACED;
}

bool ETTradeTransaction::IsTradeTransactionOrderModified(const MqlTradeTransaction &trans, const MqlTradeRequest &request, const MqlTradeResult &result )
{
   return trans.type == TRADE_TRANSACTION_REQUEST 
         && request.action == TRADE_ACTION_MODIFY 
         && OrderSelect(result.order) 
         && (ENUM_ORDER_STATE)OrderGetInteger(ORDER_STATE) == ORDER_STATE_PLACED;
}

bool ETTradeTransaction::IsTradeTransactionOrderDeleted(const MqlTradeTransaction &trans)
{
   return trans.type == TRADE_TRANSACTION_HISTORY_ADD 
         && (trans.order_type >= 2 && trans.order_type < 6) 
         && trans.order_state == ORDER_STATE_CANCELED;
}

bool ETTradeTransaction::IsTradeTransactionOrderExpired(const MqlTradeTransaction &trans)
{
   return trans.type == TRADE_TRANSACTION_HISTORY_ADD 
         && (trans.order_type >= 2 && trans.order_type < 6) 
         && trans.order_state == ORDER_STATE_EXPIRED;
}

bool ETTradeTransaction::IsTradeTransactionOrderTriggered(const MqlTradeTransaction &trans)
{
   return trans.type == TRADE_TRANSACTION_HISTORY_ADD 
         && (trans.order_type >= 2 && trans.order_type < 6) 
         && trans.order_state == ORDER_STATE_FILLED;
}

bool ETTradeTransaction::IsTradeTransactionPositionOpened(const MqlTradeTransaction &trans)
{
   return trans.type == TRADE_TRANSACTION_DEAL_ADD 
      && HistoryDealSelect(trans.deal) 
      && (ENUM_DEAL_ENTRY)HistoryDealGetInteger(trans.deal, DEAL_ENTRY) == DEAL_ENTRY_IN;
}

bool ETTradeTransaction::IsTradeTransactionPositionClosedByHedge(const MqlTradeTransaction &trans)
{
	return trans.type == TRADE_TRANSACTION_DEAL_ADD
	&& HistoryDealSelect(trans.deal)
	&& (ENUM_DEAL_ENTRY)HistoryDealGetInteger(trans.deal, DEAL_ENTRY) == DEAL_ENTRY_OUT
	&& HistorySelectByPosition(HistoryDealGetInteger(trans.deal, DEAL_POSITION_ID))
	&& (((ENUM_DEAL_TYPE)HistoryDealGetInteger(trans.deal, DEAL_TYPE) == DEAL_TYPE_SELL  && (ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY) || ((ENUM_DEAL_TYPE)HistoryDealGetInteger(trans.deal, DEAL_TYPE) == DEAL_TYPE_BUY && (ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL))
}

bool ETTradeTransaction::IsTradeTransactionPositionClosedByStopTake(const MqlTradeTransaction &trans)
{
   return trans.type == TRADE_TRANSACTION_DEAL_ADD 
      && HistoryDealSelect(trans.deal) 
      && (ENUM_DEAL_ENTRY)HistoryDealGetInteger(trans.deal, DEAL_ENTRY) == DEAL_ENTRY_OUT 
      && ((ENUM_DEAL_REASON)HistoryDealGetInteger(trans.deal, DEAL_REASON) == DEAL_REASON_SL || (ENUM_DEAL_REASON)HistoryDealGetInteger(trans.deal, DEAL_REASON) == DEAL_REASON_TP);
}

bool ETTradeTransaction::IsTradeTransactionPositionClosed(const MqlTradeTransaction &trans)
{                                                                                                                                                                                                         
   return trans.type == TRADE_TRANSACTION_DEAL_ADD 
      && HistoryDealSelect(trans.deal) 
      && (ENUM_DEAL_ENTRY)HistoryDealGetInteger(trans.deal, DEAL_ENTRY) == DEAL_ENTRY_OUT 
      && ((ENUM_DEAL_REASON)HistoryDealGetInteger(trans.deal, DEAL_REASON) != DEAL_REASON_SL && (ENUM_DEAL_REASON)HistoryDealGetInteger(trans.deal, DEAL_REASON) != DEAL_REASON_TP);
}

bool ETTradeTransaction::IsTradeTransactionPositionCloseBy(const MqlTradeTransaction &trans)
{
   return trans.type == TRADE_TRANSACTION_DEAL_ADD 
      && HistoryDealSelect(trans.deal) 
      && (ENUM_DEAL_ENTRY)HistoryDealGetInteger(trans.deal, DEAL_ENTRY) == DEAL_ENTRY_OUT_BY;
}

bool ETTradeTransaction::IsTradeTransactionPositionModified(const MqlTradeTransaction &trans, const MqlTradeRequest &request)
{
   return trans.type == TRADE_TRANSACTION_REQUEST && request.action == TRADE_ACTION_SLTP;
}
