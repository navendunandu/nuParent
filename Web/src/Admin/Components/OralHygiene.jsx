import React, { useEffect, useState } from 'react'
import { DataGrid } from '@mui/x-data-grid';
import { Box, Button, FormControl, InputLabel, MenuItem, Select, Stack, TextField, Typography, Dialog, DialogActions, DialogContent, DialogContentText, DialogTitle, } from '@mui/material';
import DeleteIcon from '@mui/icons-material/Delete';
import { db } from '../../config/firebase';
import { addDoc, collection, getDocs, deleteDoc, doc } from 'firebase/firestore';



const OralHygiene = () => {

    
    const [open, setOpen] = useState(false);
    const [oralHygieneData, setOralHygieneData] = useState([]);
    const [oralHygiene, setOralHygiene] = useState('');
    const [selectedRow, setSelectedRow] = useState(null);
    const [ageData, setAgeData] = useState([]);
    const [age, setAge] = useState('');

    const handleClickOpen = (params) => {
        setSelectedRow(params);
        setOpen(true);
    };

    const handleClose = () => {
        setOpen(false);
    };

    
    const addOralHygiene = async () => {
        try {
            await addDoc(collection(db, "oralHygiene"), { oralHygiene, age })
            loadOralHygiene();
            setOralHygiene('')
            setAge('')

        } catch (error) {
            console.error('Error adding document: ', error);
        }
    };

    const loadOralHygiene = async () => {
        try {
            const querySnapshot = await getDocs(collection(db, "oralHygiene"));
            const OralHygiene = querySnapshot.docs.map((doc, index) => ({ id: doc.id, index: index + 1, ...doc.data() }));
            setOralHygieneData(OralHygiene);
        } catch (error) {
            console.error('Error getting documents: ', error);
        }


    };

    const deleteOralHygiene = async () => {
        try {
            if (selectedRow) {
                await deleteDoc(doc(db, "oralHygiene", selectedRow.id));
                setOpen(false);
                setSelectedRow(null)
                loadOralHygiene();
            }
        } catch (error) {
            console.error('Error removing document: ', error);
        }
    };

    const loadAgeGroups = async () => {
        try {
            const querySnapshot = await getDocs(collection(db, "ageGroups"));
            const ageGroups = querySnapshot.docs.map((doc) => ({ id: doc.id, ...doc.data() }));
            setAgeData(ageGroups);
        } catch (error) {
            console.error('Error getting documents: ', error);
        }


    };



    useEffect(() => {
        loadOralHygiene();
        loadAgeGroups();
    }, []);


    
const columns = [
    { field: 'index', headerName: 'ID', flex: 1 },
   
    {
        field: 'oralHygiene',
        headerName: 'Oral Hygiene',
        flex: 3,
    },
    {
        field: "action",
        headerName: "Action",
        flex:1,
        renderCell: (params) => {
            return (
                <>
                    <DeleteIcon
                        className="divListDelete"
                        onClick={() => handleClickOpen(params)}
                    />
                </>
            );
        },
    },
];


    return (
        <>
        <div>
            <Typography variant="h4" gutterBottom>
            OralHygiene
            </Typography>
            <Box
                component="form"
                sx={{
                    '& > :not(style)': { m: 4, width: '100%' },
                }}
                noValidate
                autoComplete="off"
            >

                <Stack spacing={2} direction="row">
                    <FormControl  sx={{ minWidth: 120 }}>
                        <InputLabel id="demo-simple-select-label">Age</InputLabel>
                        <Select
                            labelId="demo-simple-select-label"
                            id="demo-simple-select"
                            value={''}
                            label="Age"
                            onChange={(event) => setAge(event.target.value)}
                            >
                                {
                                    ageData.map((doc, key) => (
                                        <MenuItem key={key} value={doc.id}>{doc.age}</MenuItem>

                                    ))
                                }
                        </Select>
                    </FormControl>
                    <TextField onChange={(event) => setOralHygiene(event.target.value)} id="outlined-basic" label="Oral Hygiene Details" variant="outlined" />

                    <Button variant="contained"sx={{width:150}} onClick={addOralHygiene}>Submit</Button>
                </Stack>

            </Box>
            <div style={{ height: 400, width: '100%' }}>
                <DataGrid
                    rows={oralHygieneData}
                    columns={columns}
                    initialState={{
                        pagination: {
                            paginationModel: { page: 0, pageSize: 5 },
                        },
                    }}
                    pageSizeOptions={[5, 10]}
                    checkboxSelection
                />
            </div>
        </div>
         <Dialog
         open={open}
         onClose={handleClose}
         aria-labelledby="alert-dialog-title"
         aria-describedby="alert-dialog-description"
     >
         <DialogTitle id="alert-dialog-title">
             {"Confirm Delete"}
         </DialogTitle>
         <DialogContent>
             <DialogContentText id="alert-dialog-description">
                 Are you sure to delete this user permanenently
             </DialogContentText>
         </DialogContent>
         <DialogActions>
             <Button onClick={handleClose}>Disagree</Button>
             <Button onClick={deleteOralHygiene} autoFocus>
                 Agree
             </Button>
         </DialogActions>
     </Dialog>
        </>
    )
}

export default OralHygiene