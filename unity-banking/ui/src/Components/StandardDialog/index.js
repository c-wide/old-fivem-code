import React, { useState } from 'react';

import Button from '@material-ui/core/Button';
import TextField from '@material-ui/core/TextField';
import Dialog from '@material-ui/core/Dialog';
import DialogActions from '@material-ui/core/DialogActions';
import DialogContent from '@material-ui/core/DialogContent';
import DialogTitle from '@material-ui/core/DialogTitle';
import InputAdornment from '@material-ui/core/InputAdornment';
import AttachMoneyIcon from '@material-ui/icons/AttachMoney';

import Nui from '../../util/Nui';

export default ({ open, setOpen, title }) => {
  const [amount, setAmount] = useState('');

  const handleChange = event => {
    if (event.target.value.match(/^\d{0,10}$/)) {
      setAmount(event.target.value);
    }
  };

  const handleSubmit = async event => {
    event.preventDefault();

    if (amount.match(/^\s*$|^0/)) {
      return;
    }

    const amountInt = parseInt(amount, 10);

    setOpen(false);

    switch (title) {
      case 'Withdraw Funds':
        await Nui.send('withdraw', { amount: amountInt });
        setAmount('');
        break;
      case 'Deposit Funds':
        await Nui.send('deposit', { amount: amountInt });
        setAmount('');
        break;
      default:
    }
  };

  const handleDialogClose = () => {
    setOpen(false);
    setAmount('');
  };

  return (
    <Dialog open={open} onClose={handleDialogClose}>
      <DialogTitle>{title}</DialogTitle>
      <DialogContent>
        <TextField
          autoFocus
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
          <Button variant="outlined" color="primary" type="submit">
            Confirm
          </Button>
        </form>
      </DialogActions>
    </Dialog>
  );
};
