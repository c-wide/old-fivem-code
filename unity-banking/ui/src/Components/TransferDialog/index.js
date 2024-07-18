import React, { useState } from 'react';
import { useSelector } from 'react-redux';

import { makeStyles } from '@material-ui/core/styles';

import Button from '@material-ui/core/Button';
import TextField from '@material-ui/core/TextField';
import Dialog from '@material-ui/core/Dialog';
import DialogActions from '@material-ui/core/DialogActions';
import DialogContent from '@material-ui/core/DialogContent';
import DialogTitle from '@material-ui/core/DialogTitle';
import InputAdornment from '@material-ui/core/InputAdornment';
import AttachMoneyIcon from '@material-ui/icons/AttachMoney';
import AccountCircleIcon from '@material-ui/icons/AccountCircle';

import Nui from '../../util/Nui';

const useStyles = makeStyles({
  root: {
    position: 'absolute',
    top: 0,
    bottom: 0,
    right: 0,
    left: 0,
    margin: 'auto',
    maxWidth: 360,
  },
});

export default ({ open, setOpen, title, quickTransfer }) => {
  const quickTransferId = useSelector(state => state.bank.accountId);
  const [accountId, setAccountId] = useState('');
  const [amount, setAmount] = useState('');

  const classes = useStyles();

  const handleChange = event => {
    switch (event.target.id) {
      case 'accountId':
        if (event.target.value.match(/^\d{0,3}$/)) {
          setAccountId(event.target.value);
        }
        break;
      case 'amount':
        if (event.target.value.match(/^\d{0,10}$/)) {
          setAmount(event.target.value);
        }
        break;
      default:
    }
  };

  const handleSubmit = async event => {
    event.preventDefault();

    if (
      (quickTransfer ? quickTransferId : accountId).match(/^\s*$|^0/) ||
      amount.match(/^\s*$|^0/)
    ) {
      return;
    }

    const amountInt = parseInt(amount, 10);
    const accountIdInt = parseInt(
      quickTransfer ? quickTransferId : accountId,
      10,
    );

    await Nui.send('transfer', { accountId: accountIdInt, amount: amountInt });
    setOpen(false);
    setAccountId('');
    setAmount('');
  };

  const handleDialogClose = () => {
    setOpen(false);
    setAccountId('');
    setAmount('');
  };

  return (
    <Dialog className={classes.root} open={open} onClose={handleDialogClose}>
      <DialogTitle>{title}</DialogTitle>
      <DialogContent>
        <form autoComplete="off">
          <TextField
            autoFocus={!quickTransfer}
            id="accountId"
            label="Account ID"
            fullWidth
            variant="outlined"
            InputProps={{
              startAdornment: (
                <InputAdornment position="start">
                  <AccountCircleIcon />
                </InputAdornment>
              ),
            }}
            value={quickTransfer ? quickTransferId : accountId}
            onChange={handleChange}
            style={{ marginBottom: 15 }}
            disabled={quickTransfer}
          />
          <TextField
            autoFocus={quickTransfer}
            id="amount"
            label="Enter Amount"
            fullWidth
            variant="outlined"
            InputProps={{
              startAdornment: (
                <InputAdornment position="start">
                  <AttachMoneyIcon />
                </InputAdornment>
              ),
            }}
            value={amount}
            onChange={handleChange}
          />
        </form>
      </DialogContent>
      <DialogActions>
        <form onSubmit={handleSubmit}>
          <Button
            variant="outlined"
            color="secondary"
            onClick={handleDialogClose}
            style={{ marginRight: 5 }}
          >
            Cancel
          </Button>
          <Button type="submit" variant="outlined" color="primary">
            Confirm
          </Button>
        </form>
      </DialogActions>
    </Dialog>
  );
};
