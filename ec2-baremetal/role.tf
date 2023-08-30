#define Roles and Policies to be associated with the ec2-instance

resource "aws_iam_policy" "policy1" {
#  path = "/users/rangapv/"
  policy = "${file("./ccm1.json")}"

}

resource "aws_iam_policy" "policy2" {
#  path = "/users/rangapv/"
  policy = "${file("./ccm2.json")}"

}


resource "aws_iam_policy" "policy4" {
#  path = "/users/rangapv/"
  policy = "${file("./ebspolicy.json")}"

}


resource "aws_iam_policy" "policy7" {
#  path = "/users/rangapv/"
  policy = "${file("./policy7.json")}"

}

resource "aws_iam_role" "k8s_role3" {
  name = "k8s_role3"
#  path = "/users/rangapv/"
#  assume_role_policy = aws_iam_policy.policy1, 
  assume_role_policy = "${file("./policy6.json")}"
  #managed_policy_arns = [ var.rolearn ]
  managed_policy_arns = [ aws_iam_policy.policy1.arn, aws_iam_policy.policy2.arn, aws_iam_policy.policy4.arn ]
  tags = {
    tag-key = "k8s-tf-role"
  }
}

resource "aws_iam_instance_profile" "k8s_profile3" {
  name = "k8s_profile3"
  role = aws_iam_role.k8s_role3.name
}
