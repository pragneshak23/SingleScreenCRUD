using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace TestWebApp
{

    public partial class Default : System.Web.UI.Page
    {
        SqlConnection sqlCon = new SqlConnection(@"Data Source=localhost;user Id=sa;password=reallyStrongPwd123;Initial Catalog=TestCRUD;");
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                btnDelete.Enabled = false;
                FillGridView();
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }

        public void Clear()
        {
            hfContactID.Value = "";
            txtName.Text = txtDate.Text = txtDesignation.Text = "";
            lblSuccessMessage.Text = lblErrorMessage.Text = "";
            btnSave.Text = "Save";
            btnDelete.Enabled = false;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
        
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand sqlCmd = new SqlCommand("ContactCreateOrUpdate", sqlCon);
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.Parameters.AddWithValue("@ConatctID", (hfContactID.Value == "" ? 0 : Convert.ToInt32(hfContactID.Value)));
            sqlCmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@DateOfBirth", txtDate.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@Designation", txtDesignation.Text.Trim());
            string message = "";
            foreach (ListItem item in lstSkills.Items)
            {
                if (item.Selected)
                {
                    message += item.Text + " ";
                }
            }
            sqlCmd.Parameters.AddWithValue("@Skills", message);
            sqlCmd.ExecuteNonQuery();
            sqlCon.Close();
            string contactID = hfContactID.Value;
            Clear();
            if (contactID == "")
                lblSuccessMessage.Text = "Saved Successfully";
            else
                lblSuccessMessage.Text = "Updated Successfully";
            FillGridView();
        }

        void FillGridView()
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlDataAdapter sqlDa = new SqlDataAdapter("ContactViewAll", sqlCon);
            sqlDa.SelectCommand.CommandType = CommandType.StoredProcedure;
            DataTable dtbl = new DataTable();
            sqlDa.Fill(dtbl);
            sqlCon.Close();
            gvContact.DataSource = dtbl;
            gvContact.DataBind();

        }

        protected void lnk_OnClick(object sender, EventArgs e)
        {
            int contactID = Convert.ToInt32((sender as LinkButton).CommandArgument);
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlDataAdapter sqlDa = new SqlDataAdapter("ContactViewByID", sqlCon);
            sqlDa.SelectCommand.CommandType = CommandType.StoredProcedure;
            sqlDa.SelectCommand.Parameters.AddWithValue("@ContactID", contactID);
            DataTable dtbl = new DataTable();
            sqlDa.Fill(dtbl);
            sqlCon.Close();
            hfContactID.Value = contactID.ToString();
            txtName.Text = dtbl.Rows[0]["Name"].ToString();
            txtDate.Text = dtbl.Rows[0]["DateOfBirth"].ToString();
            txtDesignation.Text = dtbl.Rows[0]["Designation"].ToString();
            btnSave.Text = "Update";
            btnDelete.Enabled = true;
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (sqlCon.State == ConnectionState.Closed)
                sqlCon.Open();
            SqlCommand sqlCmd = new SqlCommand("ContactDeleteByID", sqlCon);
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.Parameters.AddWithValue("@ContactID", Convert.ToInt32(hfContactID.Value));
            sqlCmd.ExecuteNonQuery();
            sqlCon.Close();
            Clear();
            FillGridView();
            lblSuccessMessage.Text = "Deleted Successfully";
        }
    }
}
