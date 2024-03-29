import React, { Fragment, useLayoutEffect, useState } from 'react'
import { DataGrid } from '@mui/x-data-grid'
import {
  Box,
  Button,
  FormControl,
  InputLabel,
  MenuItem,
  Select,
  Stack,
  TextField,
  Typography,
  Dialog,
  DialogActions,
  DialogContent,
  DialogContentText,
  DialogTitle,
} from '@mui/material'
import DeleteIcon from '@mui/icons-material/Delete'
import { db } from '../../config/firebase'
import { addDoc, collection, getDocs, deleteDoc, doc, updateDoc } from 'firebase/firestore'
import FullPageLoader from './FullPageLoader'
import EditNoteIcon from '@mui/icons-material/EditNote'

const OralHygiene = () => {
  const [open, setOpen] = useState(false)
  const [oralHygieneData, setOralHygieneData] = useState([])
  const [oralHygiene, setOralHygiene] = useState('')
  const [selectedRow, setSelectedRow] = useState(null)
  const [ageData, setAgeData] = useState([])
  const [age, setAge] = useState('')
  const [error, setError] = useState('')
  const [checkLoad, setCheckBlur] = useState(false)
  const [selectedDoc, setSelectedDoc] = useState(null)

  const handleClickOpen = (params) => {
    setSelectedRow(params)
    setOpen(true)
  }

  const handleClose = () => {
    setOpen(false)
  }

  const addOralHygiene = async (e) => {
    // e.preventDefault(); // prevent form submission
    setCheckBlur(true)
    if (!oralHygiene || !age) {
      setError('Both Brushing Details and Age are required')
      setCheckBlur(false)
      return
    }
    try {
      if(selectedDoc){
        const oralHygieneRef = doc(db, 'oralHygiene', selectedDoc)

        await updateDoc(oralHygieneRef, {
          oralHygiene, age
        })
      }else{
        await addDoc(collection(db, 'oralHygiene'), { oralHygiene, age })

      }
      setSelectedDoc(null)
      loadOralHygiene()
      setOralHygiene('')
      setAge('')
      setError('')
    } catch (error) {
      console.error('Error adding document: ', error)
    }
  }

  const loadOralHygiene = async () => {
    try {
      const querySnapshot = await getDocs(collection(db, 'oralHygiene'))
      const OralHygiene = querySnapshot.docs.map((doc, index) => ({
        id: doc.id,
        index: index + 1,
        ...doc.data(),
      }))

      const ageGroupsQuerySnapshot = await getDocs(collection(db, 'ageGroups'))
      const ageGroupsData = ageGroupsQuerySnapshot.docs.map((doc) => ({
        id: doc.id,
        ...doc.data(),
      }))

      const joinedData = OralHygiene.filter((OralHygieneItem) =>
        ageGroupsData.some((ageGroup) => ageGroup.id === OralHygieneItem.age)
      ).map((OralHygieneItem) => {
        const matchingAgeGroup = ageGroupsData.find(
          (ageGroup) => ageGroup.id === OralHygieneItem.age
        )
        return { ...OralHygieneItem, ageGroup: matchingAgeGroup.age }
      })

      setOralHygieneData(joinedData)
      setCheckBlur(false)
    } catch (error) {
      console.error('Error getting documents: ', error)
    }
  }

  const deleteOralHygiene = async () => {
    try {
      if (selectedRow) {
        setCheckBlur(true)
        await deleteDoc(doc(db, 'oralHygiene', selectedRow.id))
        setOpen(false)
        setSelectedRow(null)
        loadOralHygiene()
      }
    } catch (error) {
      console.error('Error removing document: ', error)
    }
  }

  const loadAgeGroups = async () => {
    try {
      const querySnapshot = await getDocs(collection(db, 'ageGroups'))
      const ageGroups = querySnapshot.docs.map((doc) => ({
        id: doc.id,
        ...doc.data(),
      }))
      setAgeData(ageGroups)
    } catch (error) {
      console.error('Error getting documents: ', error)
    }
  }

  const handleClickGetOneDoc = async (selectedDoc) => {
    try {
       const { row } = selectedDoc
       setOralHygiene(row.oralHygiene)
       setAge(row.age)
       setSelectedDoc(row.id)
    } catch (error) {
       console.log(error)
    }
 }  

  useLayoutEffect(() => {
    setCheckBlur(true)
    loadOralHygiene()
    loadAgeGroups()
  }, [])

  const columns = [
    { field: 'index', headerName: 'ID', flex: 1 },

    {
      field: 'oralHygiene',
      headerName: 'Oral Hygiene',
      flex: 3,
    },
    {
      field: 'ageGroup',
      headerName: 'Age Group ',
      flex: 3,
    },
    {
      field: 'action',
      headerName: 'Action',
      flex: 1,
      renderCell: (params) => {
        return (
          <Fragment>
          <DeleteIcon
             className='divListDelete'
             onClick={() => handleClickOpen(params)}
             sx={{ mx: 1 }}
          />
          <EditNoteIcon
             sx={{ mx: 1 }}
             onClick={() => handleClickGetOneDoc(params)}
          />
       </Fragment>
        )
      },
    },
  ]

  return (
    <>
      {checkLoad ? (
        <FullPageLoader />
      ) : (
        <Box>
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
              <Stack spacing={2} direction="row" sx={{ p: 2 }}>
                <FormControl sx={{ minWidth: 120 }}>
                  <InputLabel id="demo-simple-select-label">Age</InputLabel>
                  <Select
                    labelId="demo-simple-select-label"
                    id="demo-simple-select"
                    value={age}
                    label="Age"
                    onChange={(event) => {
                      setAge(event.target.value)
                      setError('')
                    }}
                  >
                    {ageData.map((doc, key) => (
                      <MenuItem key={key} value={doc.id}>
                        {doc.age}
                      </MenuItem>
                    ))}
                  </Select>
                </FormControl>
                <TextField
                  onChange={(event) => {
                    setOralHygiene(event.target.value)
                    setError('')
                  }}
                  multiline
                  maxRows={3}
                  sx={{ width: '60%', minWidth: 200 }}
                  id="outlined-basic"
                  autoComplete="off"
                  value={oralHygiene}
                  label="Oral Hygiene Details"
                  variant="outlined"
                />

                <Button
                  variant="contained"
                  sx={{ width: 150 ,maxHeight: 50 }}
                  onClick={addOralHygiene}
                >
                  Submit
                </Button>
              </Stack>
              {error && <Typography color="error">{error}</Typography>}
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
              {'Confirm Delete'}
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
        </Box>
      )}
    </>
  )
}

export default OralHygiene
