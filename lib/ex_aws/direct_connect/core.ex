defmodule ExAws.DirectConnect.Core do
  @actions [
    "AllocateConnectionOnInterconnect",
    "AllocatePrivateVirtualInterface",
    "AllocatePublicVirtualInterface",
    "ConfirmConnection",
    "ConfirmPrivateVirtualInterface",
    "ConfirmPublicVirtualInterface",
    "CreateConnection",
    "CreateInterconnect",
    "CreatePrivateVirtualInterface",
    "CreatePublicVirtualInterface",
    "DeleteConnection",
    "DeleteInterconnect",
    "DeleteVirtualInterface",
    "DescribeConnections",
    "DescribeConnectionsOnInterconnect",
    "DescribeInterconnects",
    "DescribeLocations",
    "DescribeVirtualGateways",
    "DescribeVirtualInterfaces"]


  @doc """
  AllocateConnectionOnInterconnect

  Creates a hosted connection on an interconnect.

  Allocates a VLAN number and a specified amount of bandwidth for use by a
  hosted connection on the given interconnect.
  """
  def allocate_connection_on_interconnect(client, input) do
    request(client, "AllocateConnectionOnInterconnect", input)
  end

  @doc """
  AllocatePrivateVirtualInterface

  Provisions a private virtual interface to be owned by a different customer.

  The owner of a connection calls this function to provision a private
  virtual interface which will be owned by another AWS customer.

  Virtual interfaces created using this function must be confirmed by the
  virtual interface owner by calling ConfirmPrivateVirtualInterface. Until
  this step has been completed, the virtual interface will be in 'Confirming'
  state, and will not be available for handling traffic.
  """
  def allocate_private_virtual_interface(client, input) do
    request(client, "AllocatePrivateVirtualInterface", input)
  end

  @doc """
  AllocatePublicVirtualInterface

  Provisions a public virtual interface to be owned by a different customer.

  The owner of a connection calls this function to provision a public virtual
  interface which will be owned by another AWS customer.

  Virtual interfaces created using this function must be confirmed by the
  virtual interface owner by calling ConfirmPublicVirtualInterface. Until
  this step has been completed, the virtual interface will be in 'Confirming'
  state, and will not be available for handling traffic.
  """
  def allocate_public_virtual_interface(client, input) do
    request(client, "AllocatePublicVirtualInterface", input)
  end

  @doc """
  ConfirmConnection

  Confirm the creation of a hosted connection on an interconnect.

  Upon creation, the hosted connection is initially in the 'Ordering' state,
  and will remain in this state until the owner calls ConfirmConnection to
  confirm creation of the hosted connection.
  """
  def confirm_connection(client, input) do
    request(client, "ConfirmConnection", input)
  end

  @doc """
  ConfirmPrivateVirtualInterface

  Accept ownership of a private virtual interface created by another
  customer.

  After the virtual interface owner calls this function, the virtual
  interface will be created and attached to the given virtual private
  gateway, and will be available for handling traffic.
  """
  def confirm_private_virtual_interface(client, input) do
    request(client, "ConfirmPrivateVirtualInterface", input)
  end

  @doc """
  ConfirmPublicVirtualInterface

  Accept ownership of a public virtual interface created by another customer.

  After the virtual interface owner calls this function, the specified
  virtual interface will be created and made available for handling traffic.
  """
  def confirm_public_virtual_interface(client, input) do
    request(client, "ConfirmPublicVirtualInterface", input)
  end

  @doc """
  CreateConnection

  Creates a new connection between the customer network and a specific AWS
  Direct Connect location.

  A connection links your internal network to an AWS Direct Connect location
  over a standard 1 gigabit or 10 gigabit Ethernet fiber-optic cable. One end
  of the cable is connected to your router, the other to an AWS Direct
  Connect router. An AWS Direct Connect location provides access to Amazon
  Web Services in the region it is associated with. You can establish
  connections with AWS Direct Connect locations in multiple regions, but a
  connection in one region does not provide connectivity to other regions.
  """
  def create_connection(client, input) do
    request(client, "CreateConnection", input)
  end

  @doc """
  CreateInterconnect

  Creates a new interconnect between a AWS Direct Connect partner's network
  and a specific AWS Direct Connect location.

  An interconnect is a connection which is capable of hosting other
  connections. The AWS Direct Connect partner can use an interconnect to
  provide sub-1Gbps AWS Direct Connect service to tier 2 customers who do not
  have their own connections. Like a standard connection, an interconnect
  links the AWS Direct Connect partner's network to an AWS Direct Connect
  location over a standard 1 Gbps or 10 Gbps Ethernet fiber-optic cable. One
  end is connected to the partner's router, the other to an AWS Direct
  Connect router.

  For each end customer, the AWS Direct Connect partner provisions a
  connection on their interconnect by calling
  AllocateConnectionOnInterconnect. The end customer can then connect to AWS
  resources by creating a virtual interface on their connection, using the
  VLAN assigned to them by the AWS Direct Connect partner.
  """
  def create_interconnect(client, input) do
    request(client, "CreateInterconnect", input)
  end

  @doc """
  CreatePrivateVirtualInterface

  Creates a new private virtual interface. A virtual interface is the VLAN
  that transports AWS Direct Connect traffic. A private virtual interface
  supports sending traffic to a single virtual private cloud (VPC).
  """
  def create_private_virtual_interface(client, input) do
    request(client, "CreatePrivateVirtualInterface", input)
  end

  @doc """
  CreatePublicVirtualInterface

  Creates a new public virtual interface. A virtual interface is the VLAN
  that transports AWS Direct Connect traffic. A public virtual interface
  supports sending traffic to public services of AWS such as Amazon Simple
  Storage Service (Amazon S3).
  """
  def create_public_virtual_interface(client, input) do
    request(client, "CreatePublicVirtualInterface", input)
  end

  @doc """
  DeleteConnection

  Deletes the connection.

  Deleting a connection only stops the AWS Direct Connect port hour and data
  transfer charges. You need to cancel separately with the providers any
  services or charges for cross-connects or network circuits that connect you
  to the AWS Direct Connect location.
  """
  def delete_connection(client, input) do
    request(client, "DeleteConnection", input)
  end

  @doc """
  DeleteInterconnect

  Deletes the specified interconnect.
  """
  def delete_interconnect(client, input) do
    request(client, "DeleteInterconnect", input)
  end

  @doc """
  DeleteVirtualInterface

  Deletes a virtual interface.
  """
  def delete_virtual_interface(client, input) do
    request(client, "DeleteVirtualInterface", input)
  end

  @doc """
  DescribeConnections

  Displays all connections in this region.

  If a connection ID is provided, the call returns only that particular
  connection.
  """
  def describe_connections(client, input) do
    request(client, "DescribeConnections", input)
  end

  @doc """
  DescribeConnectionsOnInterconnect

  Return a list of connections that have been provisioned on the given
  interconnect.
  """
  def describe_connections_on_interconnect(client, input) do
    request(client, "DescribeConnectionsOnInterconnect", input)
  end

  @doc """
  DescribeInterconnects

  Returns a list of interconnects owned by the AWS account.

  If an interconnect ID is provided, it will only return this particular
  interconnect.
  """
  def describe_interconnects(client, input) do
    request(client, "DescribeInterconnects", input)
  end

  @doc """
  DescribeLocations

  Returns the list of AWS Direct Connect locations in the current AWS region.
  These are the locations that may be selected when calling CreateConnection
  or CreateInterconnect.
  """
  def describe_locations(client, input) do
    request(client, "DescribeLocations", input)
  end

  @doc """
  DescribeVirtualGateways

  Returns a list of virtual private gateways owned by the AWS account.

  You can create one or more AWS Direct Connect private virtual interfaces
  linking to a virtual private gateway. A virtual private gateway can be
  managed via Amazon Virtual Private Cloud (VPC) console or the [EC2
  CreateVpnGateway](http://docs.aws.amazon.com/AWSEC2/latest/APIReference/ApiReference-query-CreateVpnGateway.html)
  action.
  """
  def describe_virtual_gateways(client, input) do
    request(client, "DescribeVirtualGateways", input)
  end

  @doc """
  DescribeVirtualInterfaces

  Displays all virtual interfaces for an AWS account. Virtual interfaces
  deleted fewer than 15 minutes before DescribeVirtualInterfaces is called
  are also returned. If a connection ID is included then only virtual
  interfaces associated with this connection will be returned. If a virtual
  interface ID is included then only a single virtual interface will be
  returned.

  A virtual interface (VLAN) transmits the traffic between the AWS Direct
  Connect location and the customer.

  If a connection ID is provided, only virtual interfaces provisioned on the
  specified connection will be returned. If a virtual interface ID is
  provided, only this particular virtual interface will be returned.
  """
  def describe_virtual_interfaces(client, input) do
    request(client, "DescribeVirtualInterfaces", input)
  end


  defp request(%{__struct__: client_module} = client, action, input) do
    client_module.request(client, action, input)
  end
end
