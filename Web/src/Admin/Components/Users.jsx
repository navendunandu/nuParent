import React, { useEffect, useState } from 'react'
import { DataGrid } from '@mui/x-data-grid'

import { Box, Typography } from '@mui/material'
import { db } from '../../config/firebase'
import { collection, getDocs } from 'firebase/firestore'
import FullPageLoader from './FullPageLoader'

const Users = () => {
  const [userData, setUserData] = useState([])
  const [checkLoad, setCheckBlur] = useState(false)

  const loadUsers = async () => {
    try {
      setCheckBlur(true)
      const querySnapshot = await getDocs(collection(db, 'users'))
      const userDatas = querySnapshot.docs.map((doc, index) => ({
        id: doc.id,
        index: index + 1,
        ...doc.data(),
      }))
      setUserData(userDatas)
      setCheckBlur(false)
    } catch (error) {
      console.error('Error getting documents: ', error)
    }
  }

  useEffect(() => {
    setCheckBlur(true)

    loadUsers()
  }, [])

  const columns = [
    { field: 'index', headerName: 'ID', flex: 1 },
    {
      field: 'name',
      headerName: 'NAME',
      flex: 3,
      renderCell: (params) => {
        const { prefix, name } = params.row
        return (
          <div>
            {prefix && <span>{prefix}. </span>}
            {name}
          </div>
        )
      },
    },
    { field: 'gender', headerName: 'GENDER', flex: 3 },
    {
      field: 'email',
      headerName: 'EMAIL',
      flex: 3,
      sortable: false,
    },
    {
      field: 'dateOfBirth',
      headerName: 'DOB',
      flex: 3,
    },
    {
      field: 'address',
      headerName: 'ADDRESS',
      flex: 3,
      sortable: false,
    },

    {
      field: 'phone',
      headerName: 'PHONE NUMBER',
      description: 'This column has a value getter and is not sortable.',
      sortable: false,
      flex: 4,
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
              Users
            </Typography>
            <div style={{ height: 400, width: '100%' }}>
              <DataGrid
                rows={userData}
                columns={columns}
                initialState={{
                  pagination: {
                    paginationModel: { page: 0, pageSize: 5 },
                  },
                }}
                pageSizeOptions={[5, 10]}
              />
            </div>
          </div>
        </Box>
      )}
    </>
  )
}

export default Users
